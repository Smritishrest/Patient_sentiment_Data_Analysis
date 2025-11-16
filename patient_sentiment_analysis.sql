SELECT * FROM Patient_sentiment.patient_sentiment_100k;

-- Count of feedbacks by sentiment --
SELECT sentiment, COUNT(*) AS feedback_count
FROM patient_sentiment_100k
GROUP BY sentiment;
-- Most of the feedbacks were positive , the negative feedbacks shows that there are rooms from improvement. --
/* RESULT: 
pOSITIVE= 54811, nEGATIVE = 25017 , Neutral = 20172 */

-- Count of feedbacks per Hospital --
SELECT hospital_name ,Count(*) as feedback_count
From patient_sentiment_100k
Group by hospital_name
order by feedback_count desc;
/* Most of the feedbacks were taken from Greenvalley Medical center
Result:
Greenvalley: 250961
St mary: 25049
Rivercare: 24972
Northside: 24888 */

-- Average sentiment score per hospital -- 
Select hospital_name, avg(sentiment_score) as avg_sentiment_score
from patient_sentiment_100k
group by hospital_name
Order by avg_sentiment_score desc;
;
/* In average, Rivercare hospital tops the list of  average sentiment scorE*/

--  Feedback count per measure (like Cleanliness, Pain Management)--
Select measure, count(*) as feedback_count
from patient_sentiment_100k
group by measure
order by feedback_count desc;
/* Most of the feebacks were recorder on the basis of staff responsiveness */ 

--  Positive vs Negative feedback per hospital -- 
select hospital_name, sentiment , count(*) as feedback_count
from patient_sentiment_100k
group by hospital_name, sentiment
order by sentiment desc;

-- Detailed feedback for a Northside health hospital --
select * from patient_sentiment_100k
where hospital_name = 'Northside Health';

-- Measures with the worst average sentiment -- 
select measure, avg(sentiment_score) as avg_sentiment_score
from patient_sentiment_100k
group by measure
order by avg_sentiment_score;
/* This shows that doctor communication needs to be improved */

/* Advanced Data Analysis */
-- Top Negative Comments --
select hospital_name, patient_comment, sentiment_score
from patient_sentiment_100k
where sentiment= 'Negative'
order by sentiment_score asc;

-- Top Positive Comments --'
select hospital_name, patient_comment, sentiment_score
from patient_sentiment_100k
where sentiment= 'Positive'
order by sentiment_score desc;

-- Sentiment distribution per measure --
select measure, 
    SUM(CASE WHEN sentiment = 'Positive' THEN 1 ELSE 0 END) AS positive_count,
    SUM(CASE WHEN sentiment = 'Negative' THEN 1 ELSE 0 END) AS negative_count
FROM patient_sentiment_100k
GROUP BY measure; 
/* This shows that positive feedbacks were more in all measures while comparing to the negative one */

-- Hospital performance ranking based on average sentiment score-- 
select hospital_name, avg(sentiment_score) as avg_sentiment_score, --  COUNT(*) AS total_feedback,-- 
    RANK() OVER (ORDER BY AVG(sentiment_score) DESC) AS hospital_rank
from patient_sentiment_100k
group by hospital_name;

-- Find hospitals with the most negative comments --
select hospital_name, count(*) as negative_count
from patient_sentiment_100k
where sentiment_score = 'Negative'
group by hospital_name
order by negative_count desc;

-- Summary --
SELECT 
    hospital_name,
    COUNT(*) AS total_feedbacks,
    SUM(CASE WHEN sentiment = 'Positive' THEN 1 ELSE 0 END) AS positive_feedbacks,
    SUM(CASE WHEN sentiment = 'Negative' THEN 1 ELSE 0 END) AS negative_feedbacks,
    ROUND(AVG(sentiment_score), 2) AS avg_sentiment_score
FROM patient_sentiment_100k
GROUP BY hospital_name;


