# Flutter eCommerce

An ecommerce flutter project

<b>Hive database </b>
<br/>
<b>Bloc</b> 
<br/>
<b>Clean Architecture </b>
<br/>
<b>Feature First </b>
<br/>

** Command to generate Adapter for hive<br/>
#flutter pub run build_runner build

# My Questions in my head during developing this application

1) <b>what i have is i got 2 different BLOC in flutter and they also have a different state</b> <br/>
  Solution: Create an event where you want to access your state; basically like if you want to access your authState then create an event inside your AuthBloc in this you can get your "authState".

3) <b>what if i have a BLOC 1 and i call the state of other BLOC 2 how to get the value ?</b> <br/>
  Solution: No you can not call directly bloc1 into bloc2, but the problem is the DOCS said, that it is not a best / good practice to call or inject Bloc1 to Bloc2, your each individaul Bloc should not know that "Other Bloc exists".
