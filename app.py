from flask import Flask,request
app = Flask(__name__)

@app.route('/',methods=['GET', 'POST'])
def hello():
    if request.method == 'POST' and request.headers['NotBad'] == "true":
       return "RealyNotBad"
    if request.method == 'GET':
       return "Only POST Method allowed! - test"
       
if __name__ == "__main__":
    app.run(debug=True)