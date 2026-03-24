-- =========================================================
-- Possible causes for the trend change
-- ---------------------------------------------------------
-- Holidays
-- Broken feature
-- Broken tracking code
-- Problems in a specific platform
-- Bots 
-- Marketing event
-- ...

-- ---------------------------------------------------------
-- Hypothesis 1: Holidays
-- ---------------------------------------------------------

-- But lets first observe if holidays could be a reason:
SELECT EXTRACT(MONTH FROM occurred_at), 
       COUNT(event_type) 
FROM tutorial.yammer_events 
WHERE event_type = 'signup_flow'
AND EXTRACT(YEAR FROM occurred_at) = 2014 
GROUP BY 1;
-- Here we can observe that the count for sign-ups has 
-- actually increased with time, without even needing a 
-- chart to observe such trend. August has a bigger count 
-- than July, against what the data shows at first.

-- And if we also check the active accounts:
SELECT EXTRACT(MONTH FROM created_at), 
       COUNT(state) FILTER (WHERE state = 'active') AS active_users,
       COUNT(state) AS total_users 
FROM tutorial.yammer_users
WHERE EXTRACT(YEAR FROM created_at) = 2014
GROUP BY 1
ORDER BY 1;
-- We will be able to see that the number has done nothing
-- but increase progressively with time, both for active and 
-- total users, even during holiday season.

-- ---------------------------------------------------------
-- Hypothesis 2: Email engagement
-- ---------------------------------------------------------

-- Therefore, what could be the issue? What if it was a
-- platform thing? What platforms are most and least affected
-- by the reduction in users?

-- Let's start with the information available on emails; We
-- can see the weekly digests received (that is, the auto-
-- matic system), if they opened emails, and if they were
-- able to click links in them.
SELECT EXTRACT(MONTH FROM occurred_at),
       COUNT(action) FILTER (WHERE action = 'sent_weekly_digest') AS weekly_email,
       COUNT(action) FILTER (WHERE action = 'email_open') AS email_opened,
       COUNT(action) FILTER (WHERE action = 'email_clickthrough') AS email_clickthrough
FROM tutorial.yammer_emails
WHERE EXTRACT(YEAR FROM occurred_at) = 2014
GROUP BY 1
ORDER BY 1; 
-- Upon doing this query we quickly find an issue: nothing
-- happened to weekly mails and opened ones, but there was
-- a clear downwards trend in august where email links
-- suddenly happened way less. We cannot know what could
-- have provoked such thing, so we would definitely have to
-- communicate it to the corresponding department.

-- However, are those all the insights we can obtain here?

-- ---------------------------------------------------------
-- Hypothesis 3: Platform-specific issues
-- ---------------------------------------------------------
-- Another one I have observed can be found when doing the
-- following query, which, as suggested at the beginning,
-- separates the number of interactions with the server
-- between platforms — that is, computers, phones and
-- tablets.

SELECT DATE_TRUNC('month', occurred_at) AS month,
       COUNT(*) FILTER (WHERE device IN ('dell inspiron desktop', 'macbook pro', 'asus chromebook', 'windows surface', 'macbook air', 'lenovo thinkpad', 'mac mini', 'acer aspire desktop', 'acer aspire notebook', 'dell inspiron notebook', 'hp pavilion desktop')) AS computer,
       COUNT(*) FILTER (WHERE device IN ('nexus 10', 'pad mini', 'samsumg galaxy tablet', 'nexus 7', 'kindle fire', 'nexus 5', 'ipad air')) AS tablet,
       COUNT(*) FILTER (WHERE device IN ('amazon fire phone', 'iphone 5', 'iphone 5s', 'htc one', 'iphone 4s', 'samsung galaxy note', 'nokia lumia 635', 'samsung galaxy s4')) AS phone
FROM tutorial.yammer_events
WHERE event_type = 'engagement'
AND EXTRACT(YEAR FROM occurred_at) = 2014
GROUP BY 1

-- If we run that query, we will be able to see that there
-- is a considerable reduction in usage of both phone and
-- tablett devices on the month of august (both recording
-- a drop of about 1/3rd of the userbase) while with
-- computers, the reduction is considerably less steep.
--
-- Combined with the drop in email clickthroughs, this 
-- suggests a potential issue affecting mobile user 
-- interaction, possibly related to app functionality or 
-- link handling as we found before.



-- =========================================================
-- FINAL CONCLUSION
-- ---------------------------------------------------------
-- The drop in user engagement observed in August 2014 does
-- not appear to be driven by seasonality or user growth.
--
-- Instead, the decline is strongly correlated with:
-- 1. A sharp decrease in email clickthrough rates
-- 2. A significant drop in mobile and tablet usage
--
-- Desktop engagement remains relatively stable, its
-- decrease most probably being a side effect of portable
-- platforms. 
--
-- This suggests a potential issue affecting mobile user
-- interaction, possibly related to email link handling or
-- mobile application performance.
--
-- Further investigation from product or engineering teams
-- is recommended.
-- =========================================================