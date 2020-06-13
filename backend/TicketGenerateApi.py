from flask import Flask
from house_ticket import generate_housie_images
import json
import  time



app = Flask(__name__)

@app.route('/get_tickets/<int:number>/')
def send_tickets(number):
    # time.sleep(5)
    myImages = generate_housie_images(number)
    # print(len(myImages))
    # print(myImages)
    return json.dumps(myImages)




if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True)