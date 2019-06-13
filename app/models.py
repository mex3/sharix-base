from flask_sqlalchemy import SQLAlchemy
from main import app

db = SQLAlchemy(app)

class CarClass(db.Model):
    __tablename__ = "classes"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20), nullable=False)

class CarModel(db.Model):
    __tablename__ = "models"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    class_id = db.Column(db.Integer, db.ForeignKey('classes.id'))

class Trip(db.Model):
    __tablename__ = "trips"
    id = db.Column(db.Integer, primary_key=True)
    from_longitude = db.Column(db.Float, nullable=False)
    from_latitude = db.Column(db.Float, nullable=False)
    models_id = db.Column(db.Integer, db.ForeignKey('models.id'))
    time_start = db.Column(db.Time(timezone=False), nullable=False)
    date_start = db.Column(db.Date, nullable=False)

class Driver(db.Model):
    __tablename__ = "drivers"
    id = db.Column(db.Integer, primary_key=True)
    models_id = db.Column(db.Integer, db.ForeignKey('models.id'))
    registered = db.Column(db.Boolean, nullable=False, default=False)
