-- ============================================
-- Customer Support SLA Analytics — SQL Queries
-- ============================================

-- 1. Overall SLA Compliance
SELECT 
    COUNT(*) AS total_tickets,
    SUM(sla_breached) AS breached_tickets,
    ROUND(100.0 * SUM(sla_breached) / COUNT(*), 2) AS breach_percentage
FROM tickets;

-- 2. SLA Breach % by Category
SELECT 
    category,
    COUNT(*) AS total_tickets,
    SUM(sla_breached) AS breached_tickets,
    ROUND(100.0 * SUM(sla_breached) / COUNT(*), 2) AS breach_percentage
FROM tickets
GROUP BY category
ORDER BY breach_percentage DESC;

-- 3. Breach % and Avg Resolution Time by Product Area
SELECT 
    product_area,
    COUNT(*) AS total_tickets,
    ROUND(AVG(resolution_minutes), 1) AS avg_resolution_minutes,
    ROUND(100.0 * SUM(sla_breached) / COUNT(*), 2) AS breach_percentage
FROM tickets
GROUP BY product_area
ORDER BY breach_percentage DESC;

-- 4. Breach % by Hour of Day
SELECT 
    CAST(strftime('%H', created_date) AS INTEGER) AS hour_of_day,
    COUNT(*) AS total_tickets,
    ROUND(100.0 * SUM(sla_breached) / COUNT(*), 2) AS breach_percentage
FROM tickets
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- 5. Top 10 Agent Performance (lowest breach rate)
SELECT 
    agent_id,
    COUNT(*) AS tickets_handled,
    ROUND(AVG(resolution_minutes), 1) AS avg_resolution_minutes,
    ROUND(AVG(csat_score), 2) AS avg_csat,
    ROUND(100.0 * SUM(sla_breached) / COUNT(*), 2) AS breach_percentage
FROM tickets
GROUP BY agent_id
ORDER BY breach_percentage ASC
LIMIT 10;

-- 6. Repeat Contact Rate by Category
SELECT 
    category,
    COUNT(*) AS total_tickets,
    SUM(is_repeat_contact) AS repeat_contacts,
    ROUND(100.0 * SUM(is_repeat_contact) / COUNT(*), 2) AS repeat_contact_rate
FROM tickets
GROUP BY category
ORDER BY repeat_contact_rate DESC;
