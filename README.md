# README

------------------------------------------*USERS*----------------------------------------------------
1) Customers 
2)Admin 
3)Superadmin 

------------------------------------------*FUNCTIONALITY*----------------------------------------------------
1) Customers:

*New customer can sign up for an account
*Customers with an account:
	- Can sign in email id
	- Can search for cars based on specific car attributes
	- Can view car detail
	- Reserve a car with time constrains
To reserve a car, go to search cars and select the car you want to book. The car details page will have a reserve car tab if the car is available.

---------------------------------------------------------------------------------------------------------
2)Admin
* Can create other admins
* Can create , update and delete cars
* Can manage reservations
* Can manage customers

----------------------------------------------------------------------------------------------------------
3)Superadmin
* Has all functionalities of the admin
* Can manage other admins and Superadmins

-----------------------------------------* OTHER NOTES *---------------------------------------------------

For Scheduling jobs: To check if the car has been returned before return time or if it has been checked out within 30 minutes has been handled by scheduling two tasks in the background. The tasks are defined in lib\tasks\scheduler.rake file. The deployment of the file on heroku requires credit card details. Due to unavailability of a card among the teammates, we have put the file in github for review but has not been incorporated with the application.
___________________________________________________________________________________________________________
Credentials:
1. Superadmin :- superadmin@mail.com Password: password
2. Admin :- admin@mail.com Password: password

