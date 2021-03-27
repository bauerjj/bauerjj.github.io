---
layout: single
title: Ackee Analytics with MongoDB Atlas using Netlify
context: Ramblings
date: 2021-03-26
categories: blog
comments: true
---

I transitioned from the spyware of Google Analytics to a more privacy focused analytics solution. I also didn't require the granularity that Google Analytics provided. My other requirement was that I'm lazy and didn't want to self-host. Thus I opted to use [Ackee](https://github.com/electerious/Ackee) and [Netlify](https://www.netlify.com/) in conjunction with [MongoDB Atlas](https://www.mongodb.com/cloud/atlas). It took me about 20 minutes to create the necessary accounts and install the small snippet of code to start seeing the analytics. 

## MongoDB Atlas

1. Create an account at [MongoDB Atlas](https://www.mongodb.com/cloud/atlas) and opt for a free account. Create a new `Project` and then click `Create a New Cluster` button and wait for it to finish.  

2. Under the `Security` column, select `Database Access` and create a new user database user by clicking `ADD NEW DATABASE USER` and choose to authenticate using the `password` method. Make the username `ackee` and create your own strong password.

3. Select `Network Access` and then `ADD IP ADDRESS` and enter `0.0.0.0/0` to make it universal since Netlify will be making the requests and not your local machine.

4. When the cluster is finished creating, select `Connect` and then `Connect your application` and note a similar connection string of `mongodb+srv://ackee:<password>@cluster0.<your-server-uri>.mongodb.net/myFirstDatabase`. That is all for now

## Netlify

1. Click the `Deploy to Netlify` button found on Ackee's [Getting Started](https://docs.ackee.electerious.com/#/docs/Get%20started#with-netlify) page. Then authenticate using your existing github credentials. 

2. Netlify will prompt you for a few credentials. Enter the following:

- ACKEE_USERNAME = `ackee`
- ACKEE_PASSWORD = `<your-strong-password>`
- ACKEE_MONGODB  = `<your-mongodb-database-password-from-atlas>`
- ACKEE_ALLOW_ORIGIN = `*`

The astrix can be replaced with your netfliy URL. Mine looks something like this `dazzling-engelbart-xxxxx.netlify.app`

**NOTE** You can change these environment variables after you create the website inside netlify under `Deploy->Environment`

3. Allow Netlify to now create your repository on github and build and publish it automatically! Login to your Ackee web interface, in `Settings` panel, set up a `New domain` in the `Domains` section. You should also see the the tracking code (embed code) with a unique `domain-id`. Copy and paste this code in the header section of your website in order to capture all vists. In Laravel, there is a unique `head.blade` template for stuffing this into. 

![ackee dashboard howto](/assets/images/ackee.png)

4. See [this blog post](https://frankindev.com/2020/12/20/selfhost-ackee-for-traffic-analytics/) on how to keep up-to-date with Ackee. 

5. You can now export all of your existing Google Analytics information into excel and delete the tracking code. 