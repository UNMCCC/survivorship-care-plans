# Survivorship Care Plans

## UNM Comprehensive Cancer Center SCP monitoring system

### Introduction

The number of cancer survivors is rapidly climbing due to increased screening and improved treatment.  Survivorship Care Plans (SCPS) summarize the patients’ treatment and is a communication tool between oncologists and primary care physicians. Here we capture some of the code created to monitor the creation and delivery of SCPs at the UNMCCC to our patient population and their PCPs.

### Data extraction and visualizations

We use our electronic medical record systems to record the different stages of the SCP lifecycle, from the last patient visit to document delivery to the patient primary provider.  We query daily the backend EMR database ( *Mosaiq* /SQL server) to obtain the current status of each SCP, last visit, and all dates about the SCP status phases for each patient.  This data is automatically staged at our institution on premise *Tableau* data visualization server. A dashboard with several views help our clinical operations committee monitor the effectiveness of the SCP processes.

### Context for the SCP process

A survivorship care plan lifecycle starts during the patient visit with his/her oncological provider that determines issuance of a cancer survivor plan for the patient to follow with the patient primary provider.  

See the lifecycle of the SCP creation overview in a simple graph.  The time flows from top to bottom. Once a provider approves the SCP, the process is over. The goal is to monitor how many SCP are created, and how long it takes to do so.

![SCP lifecycle timeline](https://github.com/UNMCCC/survivorship-care-plans/blob/master/doc_images/SCP_lifecycle.PNG)

Our SCP teams make a record of the SCP status and documents at each time of the process in the EMR.
With the help of the code below, we automate the SCP related data extraction from *Mosaiq* to see when a provider issued a SCP, the type of SCP, when the SCP team transcribed the plan, when was the SCP was approved and when was the first patient appointment.
The data extracted daily is staged on a table. Our Tableau visualization daily reads the new data and serves to the committee. A Tableau story offers several data views that reflect the transition time between the steps described above about the lifecycle of each SCP.

### Contents

We store here the extraction query as well as the ingestion query into the staging database for Tableau.  Undecided about the Tableau workbooks, as these are not open source.


