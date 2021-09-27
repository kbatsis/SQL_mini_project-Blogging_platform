--Coded in SQLite 3

--Sorts posts according to date posted
SELECT *
FROM myblog
ORDER BY Date_posted DESC;

--Finds all posts by a specific author
SELECT *
FROM myblog
WHERE Author = 'Eleni';

--Finds all posts that have the keyword "programming"
SELECT myblog.ID, Title, Main_text, Author, Date_posted
FROM myblog, keywords
WHERE myblog.ID = keywords.ID AND Keyword = 'programming';

--Finds all posts from a specific month/year combination
SELECT *
FROM myblog
WHERE strftime('%m',Date_posted) = '08' AND strftime('%Y',Date_posted) = '2021';

--Finds all posts which contain both the programming and the exercice keywords
SELECT *
FROM (SELECT myblog.ID, Title, Main_text, Author, Date_posted
      FROM myblog, keywords
      WHERE myblog.ID = keywords.ID AND Keyword = 'programming')
WHERE ID IN (SELECT ID from keywords where Keyword = 'exercise');

--Finds the author(s) with the most posts
SELECT Author, COUNT(ID) AS Total_posts
FROM myblog
GROUP BY Author
HAVING Total_posts = (SELECT COUNT(ID) AS TP
                      FROM myblog
                      GROUP BY Author
                      ORDER BY TP DESC
                      LIMIT 1);