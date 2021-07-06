from flask import Flask, jsonify, render_template, request

PIN = '1234'

app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def intro():
    if request.method == 'GET':
        return render_template('index.html', title='Hello!')
    elif request.method == 'POST':
        data = request.form.to_dict()
        code = data['code']
        if PIN == code:
            return render_template('result.html', title='Success!', data='success')
        else:
            return render_template('result.html', title='Fail!', data='fail')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port='5001', debug=True)
