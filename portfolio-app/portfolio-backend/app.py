#!/usr/bin/env python3
from flask import Flask, render_template, request, jsonify, Response
from flask_pymongo import PyMongo
import prometheus_client
from prometheus_client.core import CollectorRegistry
from prometheus_client import Summary, Counter, Histogram, Gauge
import time
import requests
import socket
import json
import os
from flask_cors import CORS, cross_origin
from bson.objectid import ObjectId
import requests

app = Flask(__name__)

app.config["MONGO_URI"] = f"mongodb://{os.environ.get('MONGO_USER')}:{os.environ.get('MONGO_PASS')}@{os.environ.get('MONGO_SERVICE_NAME')}:{os.environ.get('MONGO_PORT')}/{os.environ.get('MONGO_COLLECTION')}?authSource={os.environ.get('MONGO_AUTHSOURCE')}"

cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'


mongo = PyMongo(app)

_INF = float("inf")

graphs = {}
graphs['c'] = Counter('python_request_operations_total','The total number of processed requests.')
graphs['h'] = Histogram('python_request_duration_seconds','Histogram for the duration in seconds.', buckets=(1,2,5,6,10,_INF))
def run():
    app.run(host="0.0.0.0")

@app.route("/health", methods=["GET"])
@cross_origin()
def check():
    if request.method == "GET":
        return jsonify(status=200)

@app.route("/metrics")
@cross_origin()
def requests_count():
    res = []
    for k,v in graphs.items():
        res.append(prometheus_client.generate_latest(v))
    return Response(res, mimetype="text/plain")

# @app.route("/asd", methods=["GET"])
# @cross_origin()
# def dsa():
#     if request.method == "GET":
#         return jsonify(status=200)


@app.route("/api", methods=["GET","POST"])
@cross_origin()
def index():
    start = time.time()
    graphs['c'].inc()
    if request.method == "GET":
        try:
            output = list(mongo.db.books.find())
            for book in output:
                book["_id"] = str(book["_id"])
            end = time.time()
            graphs['h'].observe(end - start)
            return Response(
                response = json.dumps(output),
                status=200,
                mimetype="application/json"
            )
        except:
            end = time.time()
            graphs['h'].observe(end - start)
            return jsonify(status=404)
    elif request.method == "POST":
        try:
            data = request.get_json()
            Author = data['Author']
            Title = data['Title']
            Year = data['Year']
            conn = mongo.db.books
            output = conn.insert_one({'Author': Author,'Title': Title,'Year': Year})
            end = time.time()
            graphs['h'].observe(end - start)
            return jsonify(status=200)
        except:
            end = time.time()
            graphs['h'].observe(end - start)
            return jsonify(status=404)

@app.route("/api/<ObjectId:id>", methods=["GET","DELETE","PUT"])
@cross_origin()
def book(id):
    start = time.time()
    graphs['c'].inc()
    if request.method == "GET":
        try:
            output = list(mongo.db.books.find({"_id": id}))
            for book in output:
                book["_id"] = str(book["_id"])
            end = time.time()
            graphs['h'].observe(end - start)
            return Response(
                response = json.dumps(output),
                status=200,
                mimetype="application/json"
            )
        except:
            end = time.time()
            graphs['h'].observe(end - start)
            return jsonify(status=404)
    elif request.method == "DELETE":
        try:
            output = mongo.db.books.delete_one({"_id": id})
            end = time.time()
            graphs['h'].observe(end - start)
            return Response(
                response = json.dumps(output),
                status=200,
                mimetype="application/json"
            )
        except:
            end = time.time()
            graphs['h'].observe(end - start)
            return jsonify(status=404)
    elif request.method == "PUT":
        try:
            data = request.get_json()
            Author = data['Author']
            Title = data['Title']
            Year = data['Year']
            conn = mongo.db.books
            output = conn.update_one({"_id": id},{'$set': {'Author': Author,'Title': Title,'Year': Year} })
            end = time.time()
            graphs['h'].observe(end - start)
            return jsonify(status=200)
        except:
            end = time.time()
            graphs['h'].observe(end - start)
            return jsonify(status=404)

if __name__ == "__main__":
    run()