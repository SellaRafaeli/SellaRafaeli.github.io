
Security scheme proposal:

A valid session is defined by:
1. an HTTP-cookie with a user auth-token. (cookie-token)
2. an in-memory (separate) auth-token. (memory-token)

Any POST/credentialed request to server must pass these two, and the server validates both of them. 

This should protect against:
1. CSRF - a 'POST' from attacker's website cannot access the in-memory token, and thus will be ignored. 
2. XSS session-stealing - using XSS you cannot grab the HTTP-only-cookie. 