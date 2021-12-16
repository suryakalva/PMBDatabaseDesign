--create index 

CREATE index idx_hitcount on Pmb_Questions(QuestionName,PartnerCode)
CREATE index idx_tracktime on Pmb_Pmb_QuestionTally(InsertDate)
CREATE index idx_category on Pmb_Category(CategoryName)


--DML

insert into Pmb_Category(CategoryName,CategoryActive) values ('TravelItineraryInformation',1);
insert into Pmb_Category(CategoryName,CategoryActive) values ('ManagingyourAccount',1);
insert into Pmb_Category(CategoryName,CategoryActive) values ('Billing',1);
insert into Pmb_Category(CategoryName,CategoryActive) values ('TravelClaims',1);

insert into Pmb_CategoryTally(HitCount ,CategoryID) values ('77',1);
insert into Pmb_CategoryTally(HitCount ,CategoryID) values ('92',2);
insert into Pmb_CategoryTally(HitCount ,CategoryID) values ('35',3);
insert into Pmb_CategoryTally(HitCount ,CategoryID) values ('46',4);

insert into Pmb_CategoryandQuestion (QuestionID,CategoryID) values ('1','1');
insert into Pmb_CategoryandQuestion (QuestionID,CategoryID) values ('2','2');
insert into Pmb_CategoryandQuestion (QuestionID,CategoryID) values ('7','3');
insert into Pmb_CategoryandQuestion (QuestionID,CategoryID) values ('5','4');


insert into Pmb_Questions (QuestionName,Description,Answer,QuestionActive,PartnerCode)
values
('Where can I view my travel iternery on my account?','ViewTravelItenery','<p>Visit the Documents page to view all of your travel related infromation, including your most  recent deposite and   invoices.  You''ll also be able to print, email or fax a proof of payment from this page.</p>    <div class="functionalLink AdlInfo btnG" data-link="../Documents">Go to my documents</div>',1,501);
insert into Pmb_Questions (QuestionName,Description,Answer,QuestionActive,PartnerCode)
values
('Where can I find a summary of my bill?','ViewBillingSummary','<p>Visit the Billing page to view your next or previous payment information.  If you have additional questions about your bill, please give us a call.</p>  <div class="functionalLink AdlInfo btnG" data-link="../Billing">Show my billing summary</div>',1,502);
insert into Pmb_Questions (QuestionName,Description,Answer,QuestionActive,PartnerCode)
values
('Do you offer any discounts?','Discounts','<p>We offer a variety of discounts to keep you travel budgeted . If you''re eligible for a discount i, we''ll automatically apply it to your total billing  To see what discounts are already applied to your travel, look at the email confirmation . Here are some of our most commonly applied discounts*:</div>',1,503);
insert into Pmb_Questions (QuestionName,Description,Answer,QuestionActive,PartnerCode)
values
('How do I contact you if I have more questions?','ContactUs','<div class="row contactUsSection" id="contactUsSection"></div>',1,505);
insert into Pmb_Questions (QuestionName,Description,Answer,QuestionActive,PartnerCode)
values
('Why did my rate change?','RateChange','<p>We strive hard to keep the pricings constanst through out your itenery ,however things prrcing changes migh happen on out pratner comapbies to hight volume of booking or uavaiablity of  your selected booking option new booking might have been taken place</p><p>There may be ways to lower your cost;, please give us a call.</p>',1,504);


insert into Pmb_QuestionTally (Hitcount,QuestionID) values ('67',1);
insert into Pmb_QuestionTally (Hitcount,QuestionID) values ('56',2);
insert into Pmb_QuestionTally (Hitcount,QuestionID) values ('90',3);
insert into Pmb_QuestionTally (Hitcount,QuestionID) values ('23',4);
insert into Pmb_QuestionTally (Hitcount,QuestionID) values ('89',5);

--UPDATE

UPDATE Pmb_CategoryandQuestion set QuestionID =3 where CategoryandQuestionID =3;
UPDATE Pmb_CategoryandQuestion set questionID = 4 where CategoryID = 4;

--DELETE 
DELETE FROM Pmb_Questions where QuestionID = 5;

--SELECT 

SELECT Hitcount from Pmb_QuestionTally ;

--JOIN 

Select q.QuestionID,q.Description,qt.Hitcount ,qt.InsertDate from Pmb_QuestionTally qt
inner join Pmb_Questions q on q.questionID = qt.questionID
where q.questionID in (1,3,4);

Select c.CategoryName,q.Description from Pmb_Category c
inner join Pmb_CategoryandQuestion qc on c.CategoryID = qc.CategoryID
inner join Pmb_Questions q on q.questionID = qc.questionID
where c.CategoryActive = 1;

--multi-table query
Select c.CategoryName,ct.hitcount ,ct.InsertDate from Pmb_Category c
inner join Pmb_CategoryTally ct on ct. CategoryID = c.CategoryID
where Ct.hitcount <= 100
group by ct.hitcount;

--query of my choice

Select count(*) , qt.hitcount ,qt.Insertdate , q.QuestionName,q.Description from  Pmb_Questions q
inner join Pmb_QuestionTally qt on qt.QuestionID = q.QuestionID
where qt.Insertdate <= NOW() ;


-- views
-- View: vw_gethitcount_weekly
CREATE VIEW vw_gethitcount_weekly AS
select count(*) ,tally.HitCount,ques.QuestionName,ques.PartnerCode
from Pmb_Questions ques
INNER JOIN Pmb_QuestionTally tally
on ques.QuestionID=tally.QuestionID
where tally.Insertdate > DATE_ADD(NOW(), INTERVAL -7 DAY)
and ques.QuestionActive =1 
group by tally.HitCount,ques.QuestionName,ques.PartnerCode
order by Insertdate desc;

--TRIGGER
CREATE TRIGGER trg_validate_active_flag BEFORE DELETE ON pmb_Question FOR EACH ROW
IF FLAG.ACTIVE in (select QuestionActive from Pmb_Questions ) THEN SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Questions has an active flag and cannot be deleted.'
END IF;

--TRANSACTION

START TRANSACTION ;
UPDATE Pmb_QuestionTally SET Hitcount = 104 where questionID = 5;
ROLLBACK ;

START TRANSACTION ;
UPDATE Pmb_QuestionTally SET Hitcount = 104 where questionID = 5;
COMMIT ;

-- SECURITY

--Authentication

CREATE USER 'pmb_appuser'@'%' IDENTIFIED BY 'r@nd0mP@%%!';
CREATE USER 'pmb_devuser'@'%' IDENTIFIED BY 'R@nd0mp@$$2';
CREATE USER 'pmb_admin'@'%' IDENTIFIED BY 'rand0Mpa$s3';

--Authorization
GRANT CREATE USER, SELECT, INSERT, UPDATE, DELETE, CREATE ON *.* TO 'pmb_admin'@'%';
GRANT SELECT, INSERT, UPDATE ,DELETE on CutomerService.* TO 'pmb_appuser'@'%';
GRANT SELECT on CutomerService.* TO 'pmb_devuser'@'%';

show grants for 'pmb_admin'@'%';
show grants for 'pmb_appuser'@'%';
show grants for 'pmb_devuser'@'%';

--Locking

Create table locking (
	Locking_id INT NOT NULL AUTO_INCREMENT,
    Locking_exp INT NULL,
    CONSTRAINT PK_Locking_id PRIMARY KEY (Locking_id)
    ) ENGINE InnoDB;

Insert INTO locking (Locking_exp) values('0');
Insert INTO locking (Locking_exp) values('3');
Insert INTO locking (Locking_exp) values('4');
Insert INTO locking (Locking_exp) values('99');
Insert INTO locking (Locking_exp) values('277');

Select * from locking;
Update locking set locking_exp=sleep(200) where Locking_exp = 3
Select * from locking where Locking_exp = 3;

--BackupCommand

mysqldump -opt -C CutomerService >sql.dump