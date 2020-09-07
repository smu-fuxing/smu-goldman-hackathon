# Mavis GS 
> SMU SIS Goldman AWS Bloomberg Hackathon

![release published](https://github.com/fuxingloh/smu-goldman-hackathon/workflows/release%20published/badge.svg)
![web-app: deploy](https://github.com/fuxingloh/smu-goldman-hackathon/workflows/web-app:%20deploy/badge.svg)

![api: pr to master](https://github.com/fuxingloh/smu-goldman-hackathon/workflows/api:%20pr%20to%20master/badge.svg)
![api-data: pr to master](https://github.com/fuxingloh/smu-goldman-hackathon/workflows/api-data:%20pr%20to%20master/badge.svg)
![api-news: pr to master](https://github.com/fuxingloh/smu-goldman-hackathon/workflows/api-news:%20pr%20to%20master/badge.svg)
![terraform fmt -check](https://github.com/fuxingloh/smu-goldman-hackathon/workflows/terraform%20fmt%20-check/badge.svg)

## Introduction

In order to master the art of achieving financial independence, our team believes that youths **must first be financially literate to be able to make smart financial decisions**.

Given the technology age that we are in, financial information are at youths' fingertips, where they are just one search away on the internet. However, the challenge comes with filtering through the myriad amount of information available, to find the information most suitable and to understand it. 

Our team strongly emphasises the need for a product that will be able to fully serve the needs of youths with little to no financial literacy knowledge, to steer them through the vast amount of data and to not confuse them further with meaningless graphs and unfamiliar financial jargons. Our product is easy to use and easy to understand.

**Introducing Mavis by Goldman Sachs. Mavis provides youths with easily accessible educational resources, personal financial dashboards, customised portfolio optimisation recommendations and a leader board for friends to make smart financial decisions together.** 

## Features

Personal Finance Dashboard
- Portfolio Performance Analyser

Mavis Academy
 - Videos
 - Courses
 - Realtime News
- Personal Finance Calculators
  - Mortgage Loan Calculator
  - Retirement Savings Calculator
  - Retirement Savings vs Age using Monte Carlo Simulation
 
Mavis Strategy
- Insurance Savings Account + Savings Account Recommendation
- What If Portfolio Performance Analyser
- Fundamental Analysis
  - Price to Book Ratio (B/E)
  - Return on Asset Ratio (ROE)
  - Discounted Cash Flow Valuation (DCF)
  - Price to Earnings Ratio (P/E)
  - Return on Equity (ROE)
  - Debt to Equity (D/E)
  
Leaderboard
 - Community Leaderboard
 - Personal Finance Milestones
  
## Architecture 

### Architecture Diagram

![image](https://drive.google.com/uc?export=view&id=1qNwvrQGteUW6JF-Nb_jp0hDJuSwZcrru)
### Architecture Qualities
Mavis is implemented with a Service-oriented architecture approach. The 3 core services are api, data and academy written in Python, Java and Node.js by 3 different engineers. They are deployed as docker containers in a AWS ECS cluster within a private subnet spread across multiple AZ. 

An application load balancer is used to ingress traffic from the internet into the private subnet. The ECS services and EC2 instances has auto scaling to react to varying level of traffic. The ALB also serve as an edge proxy for TSL termination.

The web app is build with a vue JAMStack hosted on CloudFront with an S3 origin.

All user data are stored in DynamoDB with provisioned read/write capacity set to auto scale.

For security, all secrets are encrypted and only injected to the required containers to access external API. All services are hosted in private subnets with a nat gateway. Mavis VPC, IAM Policies and security group are tightly controlled to allow only what the service needs and nothing more.

Finally, the entire architecture is written in terraform as code. The pipelines are automated with continuous integration and continuous delivery. (Semantic Release, GitHub Workflows, Deploy on released)

## Modules
- terraform
- web-app
- api
- api-data
- api-news
