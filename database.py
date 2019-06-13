from models import *
import pandas as pd
from datetime import datetime
import os

from predefined_data import *



def _fill_predefined_tables(cars):
    try:
        class_id = {}
        for cls in cars:
            _cls = CarClass.query.filter_by(name=cls).first()
            if _cls is None:
                _cls = CarClass(name=cls)
                db.session.add(_cls)
                db.session.commit()
            class_id[cls] = _cls.id
    except Exception as e:
        print(e)
        return

    try:
        for cls in cars:
            for car in cars[cls]:
                _car = CarModel.query.filter_by(name=car).first()
                if _car is None:
                    _car = CarModel(name=car, class_id=class_id[cls])
                    db.session.add(_car)
                    db.session.commit()
    except Exception as e:
        print(e)
        return


def _get_model_id(name):
    try:
        _model = CarModel.query.filter_by(name=name.lower()).first()
    except Exception as e:
        print(e)
        return -1
    if _model is None:
        return -1
    return _model.id


def _read_csv(file, sep=',', encoding='utf-8'):
    if not os.path.exists(file):
        print('not exists path')
        return None
    try:
        data = pd.read_csv(file, sep=sep, encoding = encoding)
        return data
    except Exception as e:
        print('not read file')
        return None


def _transform_dataframe(data):
    try:
        df = pd.DataFrame()
        df['from_latitude'] = data.apply(lambda row: row['Координаты'].split(',')[1], axis=1).astype('float64') # широта
        df['from_longitude'] = data.apply(lambda row: row['Координаты'].split(',')[0], axis=1).astype('float64') # долгота

        df['car'] = data['ТС']
        df['models_id'] = df.apply(lambda row: _get_model_id(row['car']), axis=1).astype('int64')

        df['datetime_start'] = data['Дата заказа']
        df['datetime_start'] = pd.to_datetime(df['datetime_start'], format='%d.%m.%Y %H:%M')
        df['datetime_finish'] = data['Завершен']
        df['datetime_finish'] = pd.to_datetime(df['datetime_finish'], format='%d.%m.%Y %H:%M')
        df['time_start'] = df.apply(lambda row: row['datetime_start'].time(), axis=1)
        df['date_start'] = df.apply(lambda row: row['datetime_start'].date(), axis=1).astype('datetime64')

        df['correct'] = df.apply(lambda row: 1 if row['datetime_start'] < row['datetime_finish'] else 0, axis=1)

        df = df[(df['models_id'] != -1) & (df['correct'] != 0)]
        df.drop(['car', 'datetime_start', 'datetime_finish', 'correct'], axis=1, inplace=True)
        return df
    except Exception as e:
        print(e)
        return None

def _write_to_db(data, name_database, if_exists='append', clear_old_data=False):
    try:
        if clear_old_data:
            db.session.query(Trip).delete()
            db.session.commit()
        data.to_sql(name_database, db.engine, if_exists='append', index=False)
    except Exception as e:
        print(e)
        return False


def filling_in_database():
    _fill_predefined_tables(cars)
    data = _read_csv(file=file, sep=sep, encoding=encoding)
    if data is None:
        return
    df = _transform_dataframe(data)
    if df is None:
        return
    _write_to_db(data=df, name_database=name_database, if_exists=if_exists, clear_old_data=clear_old_data)


def find_driver(id):
    driver = Driver.query.filter_by(id=id).first()
    return driver

def create_driver(id):
    driver = Driver(id=id)
    db.session.add(driver)
    db.session.commit()

def get_models():
    models = db.session.query(CarModel.name, CarModel.id).all()
    return models

def get_model(model_id):
    model = db.session.query(CarModel.name).filter_by(id=model_id).first()
    if model is None:
        return ""
    return model

def set_model_and_register_user(user_id, model_id):
    try:
        Driver.query.filter_by(id=user_id).update({'models_id': model_id, 'registered': True})
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False

def get_count_trips(user_id, area, time):

    if time['time_l'] > time['time_r']:
        res1 = db.session.query(Driver.id, Trip.id, Trip.date_start).join(Trip, Driver.models_id==Trip.models_id).filter(time['time_l'] <= Trip.time_start, Trip.time_start <= '23:59:59', area['longitude_l'] <= Trip.from_longitude, Trip.from_longitude <= area['longitude_r'], area['latitude_d'] <= Trip.from_latitude, Trip.from_latitude <= area['latitude_u']).all()

        res2 = db.session.query(Driver.id, Trip.id, Trip.date_start).join(Trip, Driver.models_id==Trip.models_id).filter('00:00:00' <= Trip.time_start, Trip.time_start <= time['time_r'], area['longitude_l'] <= Trip.from_longitude, Trip.from_longitude <= area['longitude_r'], area['latitude_d'] <= Trip.from_latitude, Trip.from_latitude <= area['latitude_u']).all()
        return res1 + res2
    else:
        res = db.session.query(Driver.id, Trip.id, Trip.date_start).join(Trip, Driver.models_id==Trip.models_id).filter(time['time_l'] <= Trip.time_start,  Trip.time_start <= time['time_r'], area['longitude_l'] <= Trip.from_longitude, Trip.from_longitude <= area['longitude_r'], area['latitude_d'] <= Trip.from_latitude, Trip.from_latitude <= area['latitude_u']).all()
    return res
