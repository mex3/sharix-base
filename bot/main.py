from flask import Flask, request, jsonify
from flask_sslify import SSLify
from datetime import datetime, timedelta

from config import config, tg_bot, yandex_api

app = Flask(__name__)
sslify = SSLify(app)
app.config['DEBUG'] = config['DEBUG']
app.config['SQLALCHEMY_DATABASE_URI'] = config['SQLALCHEMY_DATABASE_URI']
app.config["SQLALCHEMY_POOL_RECYCLE"] = 299
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = config['SQLALCHEMY_TRACK_MODIFICATIONS']

import database


import telebot
from bot import Bot
from telebot import types
bot = Bot(tg_bot['token'])

from api import YandexAPI
obj_yandex_api = YandexAPI(key=yandex_api['key'], url=yandex_api['url'])

from math import cos, radians


@app.route('/{}'.format(tg_bot['token']), methods=["POST"])
def webhook():
    bot.process_new_updates()
    return "ok", 200


def preprocessing(message):
    user_id = message.from_user.id
    driver = database.find_driver(id=user_id)
    if driver is None:
        return 'need create'
    if not driver.registered:
        return 'need registered'
    if driver.registered:
        return 'registered'

def create_driver(user_id):
    database.create_driver(id=user_id)

def send_buttons_models(chat_id, text, models, user_id):
    bot.send_buttons(chat_id=chat_id, text=text, arr=models, user_id=user_id)

def selection_model(chat_id, user_id):
    models=database.get_models()
    send_buttons_models(chat_id=chat_id, user_id=user_id, models=models, text='Укажите марку вашего автомобиля')

def time_area():
    dt = datetime.now()
    res = {
        'time_l': dt.time(),
        'time_r': (dt + timedelta(minutes = 30)).time()
    }
    return res

def delta_coord_longitude(latitude, delta):
    return delta/(40000.0/360.0*cos(radians(latitude)))

def delta_coord_latitude(delta):
    return delta/111.0

def coords_regional_centers(coord_center, delta):
    res = [
        [coord_center[0], coord_center[1]],
        [coord_center[0] + delta_coord_longitude(latitude=coord_center[1], delta=delta), coord_center[1]],
        [coord_center[0] + delta_coord_longitude(latitude=coord_center[1], delta=delta), coord_center[1] + delta_coord_latitude(delta=delta)],
        [coord_center[0], coord_center[1] + delta_coord_latitude(delta=delta)],
        [coord_center[0] - delta_coord_longitude(latitude=coord_center[1], delta=delta), coord_center[1] + delta_coord_latitude(delta=delta)],
        [coord_center[0] - delta_coord_longitude(latitude=coord_center[1], delta=delta), coord_center[1]],
        [coord_center[0] - delta_coord_longitude(latitude=coord_center[1], delta=delta), coord_center[1] - delta_coord_latitude(delta=delta)],
        [coord_center[0], coord_center[1] - delta_coord_latitude(delta=delta)],
        [coord_center[0] + delta_coord_longitude(latitude=coord_center[1], delta=delta), coord_center[1] - delta_coord_latitude(delta=delta)]
    ]
    return res

def coord_area(coord, delta):
    res = {
        'longitude_l': coord[0] - delta_coord_longitude(latitude=coord[1], delta=delta),
        'longitude_r': coord[0] + delta_coord_longitude(latitude=coord[1], delta=delta),
        'latitude_u': coord[1] + delta_coord_latitude(delta=delta),
        'latitude_d': coord[1] - delta_coord_latitude(delta=delta)
    }
    return res

def coords_area(coords, delta):
    res = [coord_area(x, delta) for x in coords]
    return res

def advise(user_id, text, delta):
    res = obj_yandex_api.ymaps_geocode(text)
    if res is None:
        return "Произошла ошибка при поиске адреса"

    coord = obj_yandex_api.str_coord_to_array_float(str_coord=res['point'])
    coords = coords_regional_centers(coord_center=coord, delta=delta/3)
    areas = coords_area(coords=coords, delta=delta/6)
    time = time_area()

    count_trips = []
    for area in areas:
        query = database.get_count_trips(user_id=user_id, area=area, time=time)
        s = set()
        for item in query:
            s.add(item[2])
        count_trips.append(int(len(query)/len(s)) if len(s) > 0 else 0)

    index_max_count_trips = 0
    for i, count in enumerate(count_trips):
        if count > count_trips[index_max_count_trips]:
            index_max_count_trips = i

    print(count_trips)

    coord_to_str = obj_yandex_api.array_float_coord_to_str(array_float_coord=coords[index_max_count_trips])
    address = obj_yandex_api.ymaps_geocode(coord_to_str)

    return address['address']


def func_start(message):
    status = preprocessing(message)
    if status == 'need create':
        create_driver(message.from_user.id)
        selection_model(chat_id=message.chat.id, user_id=message.from_user.id)
    elif status == 'need registered':
        selection_model(chat_id=message.chat.id, user_id=message.from_user.id)
    elif status == 'registered':
        bot.send_message(message.chat.id, 'Вы зарегистрированы\nВведите адрес местоположения')
    else:
        bot.send_message(message.chat.id, 'Ошибка')

def func_help(message):
    bot.send_message(message.chat.id, 'Для зарегистрированных пользователей, я могу посоветовать область получения заказа')


@bot.bot.message_handler(commands=['start'])
def startCommand(message):
    func_start(message)

@bot.bot.message_handler(commands=['help'])
def helpCommand(message):
    func_help(message)

@bot.bot.message_handler(commands=['model'])
def modelCommand(message):
    status = preprocessing(message)
    if status != 'need create':
        selection_model(chat_id=message.chat.id, user_id=message.from_user.id)

@bot.bot.message_handler(content_types=['text'])
def repeat_all_messages(message):
    status = preprocessing(message)
    if status == 'registered':
        _advise = advise(user_id=message.from_user.id, text=message.text, delta=5)
        bot.send_message(message.chat.id, _advise)
    else:
        func_help(message)
        func_start(message)

@bot.bot.callback_query_handler(func=lambda call: True)
def callback_inline(call):
    if call.message:
        model_id, user_id = call.data.split(';')
        if database.set_model_and_register_user(user_id=user_id, model_id=model_id):
            model_name = database.get_model(model_id=model_id)[0]
            text = 'Ваш автомобиль: {}'.format(model_name)
        else:
            text = 'Ошибка'
        bot.send_message(call.message.chat.id, text)



if __name__ == '__main__':
    database.filling_in_database()
    app.run()
