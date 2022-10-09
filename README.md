# How to run the project

* To run the project please use `docker-compose up`
* Run the import users worker with:
  * Run `docker-compose worker bash`
  * Enter rails console with `rails c`
  * Run `ImportUsersWorker.new.perform`
* Access Users list on `http://localhost:3000/users`
* Access User page on `http://localhost:3000/users/:id`
* Navigate between pages with the `page` parameter
* Filter by status with the `status` parameter
* The same endpoints return json when the `Content-Type` header is set to `application/json`

###### Example request
```
curl --location --request GET 'http://localhost:3000/users?page=2&status=Active' \
--header 'Content-Type: application/json'
```

# Worker Setup

The import user worker is set to run every 2 hours.  
When first initializing the project, please run the worker manually to populate teh database.  
The import users worker calls a Service Object that is responsible to get the list of all users and enqueue the process user worker, which will create or update the user in the database.

## Possible Improvements

* Better error handling
