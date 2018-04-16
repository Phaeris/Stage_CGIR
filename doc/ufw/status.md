Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       Anywhere                  
21/tcp                     ALLOW       Anywhere                  
20/tcp                     ALLOW       Anywhere                  
53/udp                     ALLOW       192.168.0.0/24            
22/tcp (v6)                ALLOW       Anywhere (v6)             
21/tcp (v6)                ALLOW       Anywhere (v6)             
20/tcp (v6)                ALLOW       Anywhere (v6)             

22/tcp                     ALLOW OUT   Anywhere                  
80/tcp                     ALLOW OUT   Anywhere                  
53/udp                     ALLOW OUT   Anywhere                  
443/tcp                    ALLOW OUT   Anywhere                  
20/tcp                     ALLOW OUT   Anywhere                  
21/tcp                     ALLOW OUT   Anywhere                  
22/tcp (v6)                ALLOW OUT   Anywhere (v6)             
80/tcp (v6)                ALLOW OUT   Anywhere (v6)             
53/udp (v6)                ALLOW OUT   Anywhere (v6)             
443/tcp (v6)               ALLOW OUT   Anywhere (v6)             
20/tcp (v6)                ALLOW OUT   Anywhere (v6)             
21/tcp (v6)                ALLOW OUT   Anywhere (v6)             

Anywhere on ens18          ALLOW FWD   Anywhere on ens19         
Anywhere on ens19          ALLOW FWD   Anywhere on ens18         
Anywhere (v6) on ens18     ALLOW FWD   Anywhere (v6) on ens19    
Anywhere (v6) on ens19     ALLOW FWD   Anywhere (v6) on ens18    

