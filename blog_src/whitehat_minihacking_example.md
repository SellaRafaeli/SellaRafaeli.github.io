<!-- {"created_at": "2014-08-08", draft: "yes"} -->

## White-Hat Mini-Hacking

I accidentally 'hacked' into a website the other day. This paper is an explanation of the hack, for educational (read: professional) benefit of others as well as a tip-off to the owners of that website, so that they fix their security holes. (That's what "white hat" means.)

I call this a 'mini-hack' since it was really so trivial as to almost not qualify as a 'hack'; however, most web security breaches are such trivial manipulations of well-meaning functionalities. This one is even more trivial than most. 

The site is **http://www.founders-nation.com**, a site to pair up potential cofounders of startups. A worthy cause. On the home page we see some example cofounders we can meet via the site - example, Naama Katan. 

![](http://i.imgur.com/d1ZXO5k.png)

We click 'read more' and see her full profile page: description, what she is looking for, participates in the Israeli Woman Entrepreneurship Program... bla bla. We notice the URL is [http://www.founders-nation.com/Profile.aspx?id=927&name=Naama](http://www.founders-nation.com/Profile.aspx?id=927&name=Naama). .aspx? Yuck, but whatever. Is that the user ID exposed there in the URL? That's already a bad sign, though not a security vulnerability quite yet. Naama is presumably user number 927 (give or take) to join this site. 

Let's see if we can work with that... hmmm, looks like we can; here's one example. After signing up for the site, you confirm via email and reach a link that looks like this `http://www.founders-nation.com/AfterPageLogin.aspx?msgId=4&loc=1&id=1998`. (Hello again, user ID. So now we now founders-nation has about 2,000 users. Not a breach yet, but awkward to have that revealed.) Clicking on that link takes you to a 'welcome, your-name' page. But wait, this looks like a pretty naive link - how did it know who we are? Surely not just by the user ID? What would happen if we change the id that was assigned to us with a different id...? Say, let's try it with Naama's id: `http://www.founders-nation.com/AfterPageLogin.aspx?msgId=4&loc=1&id=927`. (notice the 927 at the end)

![](http://i.imgur.com/tHWcw05.png)

Looks like we're in. From here, effectively we **are** Naama, so we can do whatever we want: read her inbox, send messages in her name, change her details... of course, I would never do that, but you know, theoretically. 

![](http://i.imgur.com/P67MKLC.png)

![](http://i.imgur.com/EXdVrzt.png)

Of course, the one thing we can't do is change her password. Or can we? Let's head over to the 'Edit your profile' page. Ah, the password input is all obfuscated as dots instead of letters. That's good. But let's check the DOM element itself:

![](http://i.imgur.com/9Vy9iPq.png)

Hey now, is that the actual password? In clear-text?? Whoa. We can now not only change the password (and effectively shut the original user out of their own account!) but also use this password and test it in other sites - email (which we have, since it's part of the profile), facebook, paypal.... Naama has now not only been compromised on *this* site, but her entire online presence is in jeopardy. Let's hope she does not share passwords between sites. 

(Note: I changed the password here myself before screenshotting it, for Naama's benefit.)

I contacted founders-nation.com on December 13th 2014 at 18:30 IST to let them know of these issues.