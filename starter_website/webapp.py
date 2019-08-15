from flask import Flask, render_template
from flask import request, redirect
from db_connector.db_connector import connect_to_database, execute_query
#create the web application
webapp = Flask(__name__)

#provide a route where requests on the web application can be addressed
@webapp.route('/hello')
#provide a view (fancy name for a function) which responds to any requests on this route
def hello():
    return "Hello World!";

@webapp.route('/browse_games')
def browse_games():
    print("Fetching and rendering games")
    db_connection = connect_to_database()
    query = "select * from Game;"
    result = execute_query(db_connection, query).fetchall();
    print(result)
    return render_template('browse_games.html', rows=result)

@webapp.route('/add_new_games', methods=['POST','GET'])
def add_new_games():
    db_connection = connect_to_database()
    if request.method == 'POST':
        print("Add new games!");
        name = request.form['Name']
        date = request.form['Date']
        price = request.form['Price']
        query = "INSERT INTO Game (Name, Date, Price) VALUES (%s,%s,%s);"
        data = (name, date, price)
        execute_query(db_connection, query, data)
        return ('Game added!');
    else:
        query = "SELECT ID, Name from Game;"
        result = execute_query(db_connection, query).fetchall();
        print(result)
        return render_template('add_new_games.html', games = result)


@webapp.route('/update_games/<string:name>', methods=['POST','GET'])
def update_games():
    db_connection = connect_to_database()
    #display existing data
    if request.method == 'GET':
        game_query = "SELECT id, name from Game WHERE name = %s" % (name)
        game_result = execute_query(db_connection, game_query).fetchone()

        if game_result == None:
            return "No such game found!"

        return render_template('update-game.html', game = game_result)
    elif request.method == 'POST':
        print("Update Game!");
        name = request.form['name']
        date = request.form['date']
        price = request.form['price']

        query = "UPDATE Game SET name = %s, date = %s, price = %s WHERE name = %s"
        data = (name, date, price)
        result = execute_query(db_connection, query, data)
        print(str(result.rowcount) + " row(s) updated");

        return redirect('/browse_games')

@webapp.route('/delete_games/<int:id>')
def delete_games(id):
    '''deletes a game with the given id'''
    db_connection = connect_to_database()
    query = "DELETE FROM Game WHERE id = %s"
    data = (id,)

    result = execute_query(db_connection, query, data)
    return (str(result.rowcount) + "row deleted")

@webapp.route('/')
def index():
    return "<p>Are you looking for /browse_games or /hello or /add_new_games or /update_games/id or /delete_games/id </p>"

@webapp.route('/db-test')
def test_database_connection():
    print("Executing a sample query on the database using the credentials from db_credentials.py")
    db_connection = connect_to_database()
    query = "SELECT * from bsg_people;"
    result = execute_query(db_connection, query);
    return render_template('db_test.html', rows=result)
