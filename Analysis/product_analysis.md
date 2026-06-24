# Product Analysis

## Objective

Analyze product performance, category-level sales trends, pricing behavior, and freight cost patterns to understand which products drive revenue and how logistics costs vary across the catalog.

---

# Question 1: What is the overall product pricing distribution?

### Query Used

Average, Maximum and Minimum Product Price

### Result

Average Product Price: **120.65**

Maximum Product Price: **6735**

Minimum Product Price: **0.85**

### Interpretation

Products are priced between **0.85** and **6735**, with an average selling price of **120.65**.

### Why It Matters

Understanding the pricing range helps identify whether the business primarily operates in low-cost, mid-market, or premium product segments.

---

# Question 2: Which product categories generate the highest sales volume?

### Query Used

Most Selling Product Categories

### Result

| Rank | Category | Orders |
| ---- | -------- | ------ |
| 1    | cama_mesa_banho   | 11115 |
| 2    | beleza_saude   | 9670 |
| 3    | esporte_lazer   | 8641 |

### Interpretation

The category with the highest order volume was **cama_mesa_banho**.

### Why It Matters

High-volume categories often represent core customer demand and inventory priorities.

---

# Question 3: Which individual products sell the most?

### Query Used

Most Selling Products

### Result

| Rank | Product ID | Orders |
| ---- | ---------- | ------ |
| 1    | aca2eb7d00ea1a7b8ebd4e68314663af     | 527 |
| 2    | 99a4788cb24856965c36a24e339b6058     | 488 |
| 3    | 422879e10f46682990de24d770e7f83d     | 484 |

### Interpretation

The highest-selling product received **527** orders.

### Why It Matters

Identifying top-performing products helps guide stocking and promotional decisions.

---

# Question 4: What does the product sales distribution look like?

### Query Used

Frequency Distribution of Number of Products

### Result

Products Ordered Once: **18117**

Products Ordered Twice: **5817**

Products Ordered Three Times: **2651**

### Interpretation

A significant portion of products were purchased only a small number of times.

### Why It Matters

This helps determine whether revenue is concentrated among a few products or spread across a long-tail catalog.

---

# Question 5: Which categories generate the most revenue?

### Query Used

Product Categories Generating Most Revenue

### Result

| Rank | Category | Revenue |
| ---- | -------- | ------- |
| 1    | beleza_saude   | 1258681.34  |
| 2    | relogios_presentes   | 1205005.68  |
| 3    | cama_mesa_banho   | 1036988.68  |

### Interpretation

The highest revenue-generating category was **beleza_saude**.

### Why It Matters

Revenue leaders may differ from volume leaders, revealing higher-value product segments.

---

# Question 6: Which categories generate the least revenue?

### Query Used

Product Categories Generating Least Revenue

### Result

| Rank | Category | Revenue |
| ---- | -------- | ------- |
| 1    | seguros_e_servicos   | 283.29  |
| 2    | fashion_roupa_infanto_juvenil   | 569.85  |
| 3    | cds_dvds_musicais   | 730  |

### Interpretation

Several categories contribute very little revenue despite existing in the catalog.

### Why It Matters

Low-performing categories may require pricing adjustments, marketing support, or rationalization.

---

# Question 7: Which categories have the highest average product prices?

### Query Used

Highest Average Product Price by Category

### Result

| Rank | Category | Avg Price |
| ---- | -------- | --------- |
| 1    | pcs   | 1098.34    |
| 2    | portateis_casa_forno_e_cafe  | 624.29    |
| 3    | eletrodomesticos_2  | 476.12    |

### Interpretation

The most premium category was **pcs**.

### Why It Matters

Premium categories often contribute disproportionately to revenue and profit.

---

# Question 8: Which categories have the lowest average product prices?

### Query Used

Lowest Average Product Price by Category

### Result

| Rank | Category | Avg  Price |
| ---- | -------- | ---------------- |
| 1    | casa_conforto_2   | 25.34           |
| 2    | flores   | 33.64           |
| 3    | fraldas_higiene   | 40.19          |

### Interpretation

The lowest-priced category averaged **casa_conforto_2** per item.

### Why It Matters

Low-price categories typically rely on scale rather than margin.

---

# Question 9: Which categories incur the highest freight costs?

### Query Used

Highest Average Freight Cost Category

### Result

| Rank | Category | Avg Freight Cost |
| ---- | -------- | --------- |
| 1    | pcs   | 48.45    |
| 2    | eletrodomesticos_2   | 44.54    |
| 3    | moveis_colchao_e_estofado   | 42.91   |

### Interpretation

The most expensive category to ship was **pcs**.

### Why It Matters

High logistics costs can significantly reduce profitability.

---

# Question 10: Which categories incur the lowest freight costs?

### Query Used

Lowest Average Freight Cost Category

### Result

| Rank | Category | Avg Freight Cost |
| ---- | -------- | ---------------- |
| 1    | fashion_roupa_infanto_juvenil   | 11.94           |
| 2    | livros_importados   | 12.83           |
| 3    | fashion_roupa_feminina   | 12.95           |

### Interpretation

The least expensive category to ship was **fashion_roupa_infanto_juvenil**.

### Why It Matters

Low shipping-cost products can improve operational efficiency and margins.

---

# Question 11: Which categories spend the highest percentage of product value on freight?

### Query Used

Percentage Freight Cost Compared to Product Price

### Result

| Rank | Category | Avg Freight % of Product Price |
| ---- | -------- | ------------------------------ |
| 1    | casa_conforto_2   | 93.386%                        |
| 2    | dvds_blu_ray   | 83.304%                        |
| 3    | eletronicos  | 68.351%                        |

### Interpretation

In some categories, freight represents a substantial percentage of product value.

### Why It Matters

Products with excessive freight-to-price ratios may be difficult to scale profitably.

---

# Question 12: How does product weight affect freight costs?

### Query Used

Freight Cost Compared to Weight Categories

### Result

| Weight Category | Avg Freight Cost |
| --------------- | ---------------- |
| Light           | [FILL]           |
| Medium          | [FILL]           |
| Heavy           | [FILL]           |

### Interpretation

Freight costs increase as product weight increases.

### Why It Matters

Understanding this relationship helps optimize packaging, shipping strategies, and pricing decisions.

---

# Business Recommendations

## Product Portfolio Optimization

Based on sales distribution:

**Continue prioritizing high-performing products during peak demand periods while maintaining a balanced and diversified product catalog.**

---

## Revenue Growth Opportunities

Based on category revenue performance:

**Expand product offerings within top-performing categories to capture additional customer demand.**

---

## Pricing Strategy

Based on average product prices:

**Premium product categories should receive differentiated positioning and targeted promotions to maximize revenue potential.**

---

## Freight Cost Management

Based on freight cost analysis:

*Freight costs should be continuously monitored, particularly for categories with high shipping expenses, to protect profitability.**

---

## Logistics Efficiency

Based on weight versus freight analysis:

**Heavier products may require specialized shipping strategies or pricing policies to ensure transportation costs do not significantly erode margins.**
