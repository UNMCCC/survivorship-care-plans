# Survivorship Care Plans

## UNM Comprehensive Cancer Center SCP monitoring system

### Introduction

The number of cancer survivors is rapidly climbing due to increased screening and improved treatment.  Survivorship Care Plans (SCPS) summarize the patients’ treatment and is a communication tool between oncologists and primary care physicians. Here we capture some of the code created to monitor the creation and delivery of SCPs at the UNMCCC to our patient population and their PCPs.

### Data extraction and visualizations

We use our electronic medical record systems to record the different stages of the SCP lifecycle, from the last patient visit to document delivery to the patient primary provider.  We query daily the backend EMR database ( *Mosaiq* /SQL server) to obtain the current status of each SCP, last visit, and all dates about the SCP status phases for each patient.  This data is automatically staged at our institution on premise *Tableau* data visualization server. A dashboard with several views help our clinical operations committee monitor the effectiveness of the SCP processes.

### Contents

We store here the extraction query as well as the ingestion query into the staging database for Tableau.  Undecided about the Tableau workbooks, as these are not open source.

