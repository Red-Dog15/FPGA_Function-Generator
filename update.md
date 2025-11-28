**UPDATE 1.0** <br /> <br />
Problem: <br />
* button incrementer not updating
<br />

INFO: <br />  
* db_time comparator variable not reaching 1,000,000 ps mark. This comparison is not firing.
<br />
      &nbsp; &nbsp;  <img width="357" height="582" alt="image" src="https://github.com/user-attachments/assets/610175fc-a777-41c9-84a9-c8d18be750eb" /> <br /> <br />

* db_time only reaches 500.
<br />
<br />

**UPDATE 1.1**  <br />  <br />
Problem : <br />
* Testbench crashing at 20ms when count changes <br />

Fix: <br />  
* Changed count to set to 0 rather than maxcount <br />  

Problem : <br />
* Testbench decrementing on button 0 press rather than incrementing
* Before Button0 debouncer time:  
&nbsp; &nbsp; &nbsp; &nbsp;<img width="305" height="502" alt="image" src="https://github.com/user-attachments/assets/27230deb-f236-40e5-bf50-3e253ef5783c" /><br />

* After Button0 debouncer time:  <br />
&nbsp; &nbsp; &nbsp; &nbsp;<img width="353" height="534" alt="image" src="https://github.com/user-attachments/assets/b5f46a3a-9778-4bbd-9d35-13498111386c" />




Fix: <br />  

* adjusted upper and lower bounds of count variable to match max_count
* changed sync to reverse logic
* Before Button0 debouncer time:  
&nbsp; &nbsp; &nbsp; &nbsp;  <img width="555" height="722" alt="image" src="https://github.com/user-attachments/assets/1b3bb6c5-1631-4acd-8ab9-381be7093c0c" />


* After Button0 debouncer time: ( here the button increments twice as the testbench suggests)  <br />
&nbsp; &nbsp; &nbsp; &nbsp;<img width="320" height="709" alt="image" src="https://github.com/user-attachments/assets/22c3942f-911a-445d-b066-8b1bca49bd40" />

**UPDATE 1.2: Wave Multiplexer** <br /> <br />

Problem : <br />
* Multiplexer wave stuck on static value, not continuously changing as it should

Fix: <br />  

* changed the sensitivity list of the state machine to handle component output wave parameters. Now it can see the values changing
&nbsp; &nbsp; &nbsp; &nbsp;  <img width="523" height="128" alt="image" src="https://github.com/user-attachments/assets/a3a661e0-0744-4a35-9259-07c9b56d0bde" />



