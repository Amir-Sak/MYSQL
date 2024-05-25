CREATE TABLE employee_performance (
    employee_id INT,
    employee_name VARCHAR(255),
    department VARCHAR(255),
    performance_score INT,
    review_date DATE
);
select * 
from employee_performance ;

INSERT INTO employee_performance (employee_id, employee_name, department, performance_score, review_date) VALUES
(1, 'Alice Johnson', 'Sales', 85, '2023-01-15'),
(2, 'Bob Smith', 'Sales', 90, '2023-03-10'),
(3, 'Charlie Brown', 'Marketing', 88, '2023-02-20'),
(4, 'David Wilson', 'Sales', 78, '2023-05-15'),
(5, 'Eva Green', 'Marketing', 92, '2023-04-01'),
(6, 'Frank White', 'Sales', 82, '2023-06-22'),
(7, 'Grace Black', 'Marketing', 80, '2023-01-10'),
(8, 'Hannah Blue', 'Marketing', 85, '2023-03-05'),
(9, 'Ian Red', 'Sales', 95, '2023-04-10'),
(10, 'Jack Purple', 'Marketing', 87, '2023-06-15'),
(11, 'amir saker', 'finance', 83, '2024-06-15');
-- Calculate Row Numbers
-- This query assigns a unique sequential integer to each row within the same department, ordered by the review date.
SELECT 
    employee_id, 
    employee_name, 
    department, 
    performance_score, 
    review_date,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY review_date) AS row_num
FROM 
    employee_performance;
    
-- Rank Performance Scores
-- This query ranks employees within each department based on their performance scores, with ties receiving the same rank.

with duplicatie as
(SELECT 
    employee_id, 
    employee_name, 
    department, 
    performance_score, 
    review_date,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY review_date) AS row_num
FROM 
    employee_performance)
select *
from duplicatie 
where row_num > 1 ;

WITH duplicates AS (
    SELECT 
        employee_id, 
        ROW_NUMBER() OVER (PARTITION BY department ORDER BY review_date) AS row_num
    FROM 
        employee_performance
)
DELETE  
FROM employee_performance
WHERE employee_id IN (SELECT employee_id FROM duplicates WHERE row_num > 1);

select * 
from employee_performance ;


