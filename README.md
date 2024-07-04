# drugSystem-MTA-
 This resource is specific to the game Multi Theft Auto. Special drug system for RPG servers
 
# Explain resource
 This resource makes the player able to use special abilities, specifically 6 of the abilities

 1- Surgex --> 200 Health 

 2- Speed --> speed Player

 3- Adrenline --> increment health 2 every 3 secs

 4- Weed --> high jump

 5- Viper --> less damage

 6- Havoc --> strong bullets


#Note
The player's number of units is stored in 

setElementData( ThePlayer ,
 ( drug.SurgeX  |  drug.Speed  | drug.Adrenaline  |  drug.Weed  | drug.Viper  |  drug.Havoc )  ,  count(0-50)  )  .

It is not stored within the account.

If you want to register it within the account, you must use setAccountData with getAccountData 

, while entering and exiting the server
