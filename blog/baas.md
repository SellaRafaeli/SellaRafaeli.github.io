I am interested in the concept of building a **BaaS (backend-as-a-service) platform**, where one could easily create, configure and manage a backend for their mobile/web apps, without having to write code or manage any platform. A "Wix for Backends", if you will. 

### Abstraction is Good 

AWS abstracts away hardware (IaaS); Heroku abstracts away infra (PaaS); logically we can abstract away the platform (BaaS). 

In every abstraction we lose granularity and gain simplicity or ease of use. Some people need to fine-tune their own hardware / platform / code; for those people, AWS / Heroku / BaaS is not a good fit. For most applications, they all are - most infrastructures and platforms are identical; everyone runs x86 and needs a load balancer. Similarly, most BEs are either identical (users/posts CRUD) or have a BL (business logic) that can be *generalized* and abstracted. 

### DRY

Entrepreneurs that want to create a marketplace for dogs and dog-walkers or a track-my-beer app or "smart fridge" to monitor your milk consumption - anything from the trivial to the enterprise - have BEs they need to set up. I posit the 'correct' approach today is to use IaaS for the infra (goes without saying), PaaS for the platform (not yet consensus, but should be), and, I posit - a configurable BaaS for the logic. 

You'll have some CRUD endpoints, one or more DBs, AuthN-&-AuthZ, emails, push notifs, resource hosting, maybe a CDN, async background workers, cron jobs, a bit of logic. That's 80% of what every BE entails. One can build a generic, configurable SaaS to allow non-BE devs (or lazy/efficient BE devs) to skip the boilerplate BE code and configure it instead of coding it. As RoR's convention-over-config mantra encourages: most apps' BL is, in all honesty, cookie-cutter stuff.

### The Others 

If the reader has been convinced of the merit of BaaS, we can move on to Parse. Parse.com is the biggest name that already proved the product-market fit/demand of the all of the above. It wasn't perfect, but it was clearly a much-needed tool for indie app devs (and others), and a sign of things to come. FB acquired Parse and recently decided to shut it down; while chump change for FB, this is a world of hurt for Parse's users. Future users might be wary of lock-in, but the need is still there. 

Other big names in the same space are Firebase and Kinvey. Both are large and well-funded but are not very dominant. The Israeli reader might be familiar with BackAnd.

* Parse   (founded 2011, acquired by FB in 2013)
* Firebase(founded 2011, acquired by Google in 2014)
* Kinvey  (founded 2010, raised ~10M$)
* BackAnd (founded 2014, raised ~3M$) 

Obviously, these are just the success stories. However, briefly checking out these companies, I believe it is possible to out-execute them. 

### Business Model & Differentiation 

The market is big enough for multiple BaaS offerers (similarly to the Iaas/PaaS space), but variations in the market/product could help set aside a competing product. 

Here are some of the possible flavours of a BaaS offerer (non-mutually-exclusive):

1. **Hosted BaaS**. This is the classic, prevalent model of all of the above. 
2. **Open Source** it. Similarly to Wordpress.com/.org model: you can either host it yourself, or use our paid hosting. This benefits from potential community investment in dev. 
3. **Backend-as-a-product**, where the end result is your own running BE over Heroku over AWS, giving the customer a running BE they can extend-modify-control, prevening the danger of lock-in and allowing total customization. 
4. **Humans** - instead of a pure SaaS, let (our) humans configure the BE for you. These humans can be CMS-operators rather than the senior BE devs you would need to build an API from scratch. 

These are flavours and differentiation which merit more discussion, but the core product is the same - building an abstract BE generator, and a tool to allow humans to instantiate it. 

### Me

If you are reading this, you probably know me - Sella Rafaeli. If you have constructive feedback or think you would be interested in such a project, hit me up. Let's build the next BaaS. :)
