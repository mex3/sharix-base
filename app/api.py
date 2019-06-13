import requests
import json

class YandexAPI():
    _instance = None
    def __new__(cls, *args, **kwargs):
        if cls._instance == None:
            cls._instance = super().__new__(cls)
        return cls._instance

    def __init__(self, key, url):
        self.key = key
        self.url = url

    def ymaps_geocode(self, request_text):
        resp = requests.get(self.url.format(self.key, request_text))
        try:
        	point = resp.json()['response']['GeoObjectCollection']['featureMember'][-1]['GeoObject']['Point']['pos']
        	address = resp.json()['response']['GeoObjectCollection']['featureMember'][-1]['GeoObject']['metaDataProperty']['GeocoderMetaData']['text']
        	d = {'point': point, 'address': address}
        	return d
        except:
            return None

    def str_coord_to_array_float(self, str_coord):
        coord = str_coord.split(' ')
        res = [float(coord[0]), float(coord[1])]
        return res

    def array_float_coord_to_str(self, array_float_coord):
        res = str(array_float_coord[0]) + ',' + str(array_float_coord[1])
        return res
