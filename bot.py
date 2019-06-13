import json
from flask import request
import telebot
from telebot import types

class Bot():
    _instance = None
    def __new__(cls, *args, **kwargs):
        if cls._instance == None:
            cls._instance = super().__new__(cls)
        return cls._instance

    def __init__(self, token):
        self.bot = telebot.TeleBot(token)
        self.URL = 'https://api.telegram.org/bot{}/'.format(token)
        self.offset = 0


    def process_new_updates(self):
        self.bot.process_new_updates([telebot.types.Update.de_json(request.stream.read().decode("utf-8"))])

    def send_message(self, chat_id, message):
        try:
            self.bot.send_message(chat_id, message)
        except Exception as e:
            return

    def send_buttons(self, chat_id, text, arr, user_id):
        try:
            markup = types.InlineKeyboardMarkup()
            for item in arr:
                data = str(item[1]) + ';' + str(user_id)
                button = types.InlineKeyboardButton(text=item[0], callback_data=data)
                markup.add(button)
            self.bot.send_message(chat_id, text, reply_markup=markup)
        except Exception as e:
            print(e)
            return
