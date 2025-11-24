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

UPDATE 1.1  <br />  <br />
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
* 