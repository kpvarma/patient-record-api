patients = Patient.create([
	{ name: 'Ram', age: 17, blood_group: "O+", contact_details: "C/O Kousalya, Ayodhya" }, 
	{ name: 'Lakshman', age: 17, blood_group: "O+", contact_details: "C/O Sumithra, Ayodhya" }, 
	{ name: 'Bharatha', age: 17, blood_group: "A+", contact_details: "C/O Kaikeyi, Ayodhya" }, 
	{ name: 'Shatrugna', age: 17, blood_group: "A+", contact_details: "C/O Sumithra, Ayodhya" }, 
	{ name: 'Sita', age: 12, blood_group: "B+", contact_details: "C/O Janaka, Kashi" }, 
])

users = User.create([
	{ name: 'User 1', password: "Password@1" }, 
	{ name: 'User 2', password: "Password@1" }, 
	{ name: 'User 3', password: "Password@1" }
])
