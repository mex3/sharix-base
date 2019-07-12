
POSTGRES = {
    'user': 'user',
    'pw': 'password',
    'db': 'database',
    'host': 'localhost',
    'port': '5432',
}

config = {
    'DEBUG': False,
    'SQLALCHEMY_DATABASE_URI': 'postgresql://%(user)s:%(pw)s@%(host)s:%(port)s/%(db)s' % POSTGRES,
    'SQLALCHEMY_TRACK_MODIFICATIONS': False
}

tg_bot = {
    'token': 'token_telegram_bot'
}

yandex_api = {
    'key': 'key_yandex_api',
    'url': 'https://geocode-maps.yandex.ru/1.x/?apikey={}&format=json&geocode={}&results=1'
}
