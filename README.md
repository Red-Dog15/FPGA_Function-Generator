# FPGA_Function-Generator
A function Generator designed for FPGA system on Cyclone 5, DE1-SOC board

-- **INFO:**
  
  * simulation: of PWM waveform:
  <img width="1300" height="602" alt="image" src="https://github.com/user-attachments/assets/835a5edd-4206-4a21-975a-5eb7562815ca" />
  <br /> <br />

 **Button Incrementer**:<br />

  * This design includes a button incrementer component. This component increases or decreases the period depending on the button used and the component implementations.<br />

  * Starting Period of the System (approximately 2,586,939 ps):

  &nbsp; &nbsp; &nbsp; &nbsp; <img width="184" height="700" alt="image" src="https://github.com/user-attachments/assets/c104d963-e41c-4b4d-8752-6338c26ada2d" />
  * Period of the System after using the button incrementer twice (approximately 15,482,505 ps):
  
  &nbsp; &nbsp; &nbsp; &nbsp; <img width="532" height="715" alt="image" src="https://github.com/user-attachments/assets/43b379ea-66d1-4f0c-9bd9-08880a79c59e" />

  * These screenshots are taken from model sim, and were taken at the same scale

**PWM_SQUARE_WAVE**
Values for Duty Cycle (Slightly off due to measurement accuracy):
* Starting Duty Cycle (50%):  
&nbsp; &nbsp; &nbsp; &nbsp; <img width="386" height="672" alt="image" src="https://github.com/user-attachments/assets/bb1bfe26-4215-4952-b20b-1d58c231101a" />
* Duty Cycle after 2 button incrementations (70&):  
&nbsp; &nbsp; &nbsp; &nbsp; <img width="374" height="709" alt="image" src="https://github.com/user-attachments/assets/ddcbfd0b-5ac0-4fbc-be3c-526ef690038a" />

-- **Contributers:**
* RedDog15
