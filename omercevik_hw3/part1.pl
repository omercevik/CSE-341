%		   CSE 341
%	Programming Languages
%	 	 Homework 3
%		   Part 1
%		 Omer Cevik
%		  161044004

% 	Room
%	ID		Capacity	Equipment
%	Z06			10		Handicapped, Projector
%	Z11			10		Handicapped, Smartboard

%	room(ID,Capacity,Equipment).

room(z06,10,handicapped).
room(z06,10,projector).
room(z11,10,handicapped).
room(z11,10,smartboard).

%	Course
%	ID		Instructor	Capacity	Hour	Room
%	CSE341	genc			10		 4		Z06
%	CSE343	turker			6		 3		Z11
%	CSE331	bayrakci		5		 3		Z06
%	CSE321	gozupek			10		 4		Z11

%	course(ID,Instructor,Capacity,Hour,Room).

course(cse341,genc,10,4,z06).
course(cse343,turker,6,3,z11).
course(cse331,bayrakci,5,3,z06).
course(cse321,gozupek,10,4,z11).

%	Instructor
%	ID			Courses		Preference
%	genc		CSE341		projector	
%	turker		CSE343		smartboard	
%	bayrakci	CSE331
%	gozupek		CSE321		smartboard

%	instructor(ID,Courses,Preference).

instructor(genc,cse341,projector).
instructor(turker,cse343,smartboard).
instructor(bayrakci,cse331,empty).
instructor(gozupek,cse321,smartboard).

%	Student
%	SID 	Courses				Hcapped
%	1	CSE341,CSE343,CSE331		no
%	2	CSE341,CSE343				no
%	3	CSE341,CSE331				no
%	4	CSE341						no
%	5	CSE343,CSE331				no
%	6	CSE341,CSE343,CSE331		yes
%	7	CSE341,CSE343				no
%	8	CSE341,CSE331				yes
%	9	CSE341						no
%	10	CSE341,CSE321				no
%	11	CSE341,CSE321				no
%	12	CSE343,CSE321				no
%	13	CSE343,CSE321				no
%	14	CSE343,CSE321				no
%	15	CSE343,CSE321				yes


%	student(SID,Courses,Handicapped).

student(1,cse341,no).
student(1,cse343,no).
student(1,cse331,no).
student(2,cse341,no).
student(2,cse343,no).
student(3,cse341,no).
student(3,cse331,no).
student(4,cse341,no).
student(5,cse343,no).
student(5,cse331,no).
student(6,cse341,yes).
student(6,cse343,yes).
student(6,cse331,yes).
student(7,cse341,no).
student(7,cse343,no).
student(8,cse341,yes).
student(8,cse331,yes).
student(9,cse341,no).
student(10,cse343,no).
student(10,cse321,no).
student(11,cse341,no).
student(11,cse321,no).
student(12,cse343,no).
student(12,cse321,no).
student(13,cse343,no).
student(13,cse321,no).
student(14,cse343,no).
student(14,cse321,no).
student(15,cse343,yes).
student(15,cse321,yes).

%	Occupancy		
%	ID	Hour	Course
%	Z06	8		CSE341
%	Z06	9		CSE341
%	Z06	10		CSE341
%	Z06	11		CSE341
%	Z06	12	
%	Z06	13		CSE331
%	Z06	14		CSE331
%	Z06	15		CSE331
%	Z06	16		
%	Z11	8		CSE343
%	Z11	9		CSE343
%	Z11	10		CSE343
%	Z11	11		CSE343
%	Z11	12	
%	Z11	13	
%	Z11	14		CSE321
%	Z11	15		CSE321
%	Z11	16		CSE321

%	occupancy(RoomID,Hour,CourseID).

occupancy(z06,8,cse341).
occupancy(z06,9,cse341).
occupancy(z06,10,cse341).
occupancy(z06,11,cse341).
occupancy(z06,12,empty).
occupancy(z06,13,cse331).
occupancy(z06,14,cse331).
occupancy(z06,15,cse331).
occupancy(z06,16,empty).
occupancy(z11,8,cse343).
occupancy(z11,9,cse343).
occupancy(z11,10,cse343).
occupancy(z11,11,cse343).
occupancy(z11,12,empty).
occupancy(z11,13,empty).
occupancy(z11,14,cse321).
occupancy(z11,15,cse321).
occupancy(z11,16,cse321).

% Check whether there is any scheduling conflict.
conflicts(CourseID1,CourseID2) :- occupancy(A,X,CourseID1),occupancy(A,X,CourseID2).

% Check which room can be assigned to a given class. 
assign(RoomID,CourseID) :- occupancy(RoomID,Hour,CourseID),write("Hour is : "),write(Hour).

% Check which room can be assigned to which classes.
assign(RoomID,CourseID,_) :- occupancy(RoomID,Hour,CourseID),not(CourseID == empty),write("Hour is : "),write(Hour).

% Check whether a student can be enrolled to a given class.
enroll(StudentID,CourseID) :- (student(StudentID,CourseID,H),H == no);
							  (student(StudentID,CourseID,H),H == yes) -> (course(CourseID,_,_,_,RoomID) -> room(RoomID,_,Hand) -> Hand == handicapped).

% Check which classes a student can be assigned.
enroll(StudentID,CourseID,_) :- (student(StudentID,CourseID,H),H == no);
								(student(StudentID,CourseID,H),H == yes) -> (course(CourseID,_,_,_,RoomID) -> room(RoomID,_,Hand) -> Hand == handicapped).