# Autoencoder-based-Spatial-Modulation

## 📌 Overview
This repository contains code and models for **Autoencoder-based Spatial Modulation (AE-SM)**. The project implements **open-loop and closed-loop autoencoders** to deliver low-complexity solutions to mitigate performance degradation of SM in high antenna correlation scenarios.

This work is published in the **IEEE Internet of Things Journal**:  
**S. Shrestha et al.,** "*Autoencoder-Based Spatial Modulation for the Next Generation of Wireless Networks,*"  
*IEEE Internet of Things Journal, vol. 11, no. 22, pp. 36322-36334, 15 Nov. 2024.*  
DOI: [10.1109/JIOT.2024.3390443](https://doi.org/10.1109/JIOT.2024.3390443)

## 🚀 Features
- **Deep Learning for Wireless Communication**: Uses autoencoder architectures to optimize spatial modulation in Rician fading channel.
- **Custom Neural Network Layers**: Includes specialized layers such as DataLayer and SMLayer.
- **BLER Analysis**: Provides evaluation scripts for Block Error Rate benchmarking.

## 🛠️ Technologies Used
- **MATLAB**: Used for simulations and model development.
- **Deep Learning Toolbox**: Used to implement autoencoder models with standard and custom layers.
- **Wireless Communication Toolbox**: Supports MIMO rician fading channel simulations.

## 🏗️ Project Structure

The project is organized into the following main directories:

### Open Loop AE and Closed Loop AE
Both contain the following autoencoder implementations:
- Simple SM AE
- Control bit encoded AE
- AE with Antenna Signature

### Additional Directories/ Files
- `BestModels/`: Best models for each framework from hyperparameter tuning for each test case
- `Models/`: Best models of each autoencoder framework for each test case
- `Results/`: Contains BLER values and constellation plots
- `HyperparameterTuning/`: BLER plots for each test case for best model selection
- `FrameworksComparison/`: Comparison of BLER of best model for each framework for different test cases
- `LearnedConstellation/`: Constellations learnt by best models in each test case
- `BLERPlots_xxFrameworksComparison_xx.m`: Plots BLER vs Eb/No curves comparison plots for all autoencoders and baseline for appropriate test cases

## 📜 Key Files in Each AE Implementation (Open Loop AE/xx AE or Closed Loop AE/xx AE)

### Main Model Files
- `Model.m`: Energy normalization with 1 hidden layer at encoder
- `Model_encoder2.m`: Energy normalization with 2 hidden layers at encoder
- `Model_power_constraint.m`: Power normalization with 1 hidden layer at encoder
- `Model_power_constraint_encoder2.m`: Power normalization with 2 hidden layers at encoder

### Training Files
- `TrainNetwork.m`: Training function for 1 hidden layer with energy normalization
- `TrainNetwork_encoder2.m`: Training function for 2 hidden layers with energy normalization
- `TrainNetwork_power_constraint.m`: Training function for 1 hidden layer with power normalization
- `TrainNetwork_power_constraint_encoder2.m`: Training function for 2 hidden layers with power normalization

### Custom Layers
- `DataLayer.m`: Implements Data Layer
- `ControlLayer.m`: Implements Control Layer
- `pathGainLayer.m`: Implements Pathgain Layer
- `helperAEWNormalizationLayer.m`: Implements Normalization Layer
- `SMLayer.m`: Implements Spatial Modulation Layer
- `Matlab_MIMOLayer.m`: Implements MIMO channel Layer
- `helperAEWAWGNLayer.m`: Implements AWGN Layer

### Helper Functions
- `helperAEWPlotConstellation.m`: Plots learned constellations
- `helperAEWEncode.m`: Passes input through learned encoder for testing
- `helperAEWDecode.m`: Passes received signal through learned decoder for testing
- `bler_sm_psk_mld_new.m`: Computes BLER for baseline PSK based SM with MLD
- `bler_sm_qam_mld_new.m`: Computes BLER for baseline QAM based SM with MLD

## 🚀 Steps to Train a New Autoencoder Model

1. Navigate to the appropriate AE folder (Open Loop AE/xx AE or Closed Loop AE/xx AE)

2. Generate Dataset:
   - Run `Data_Generator.m`
   - Set appropriate values for:
     - `k` (total number of information bits)
     - `c` (total number of control bits)
     - `KFactor` (Rician factor)
   - Edit lines writematrix(train_data,'Datasets\xx.csv'), writematrix(validation_data,'Datasets\xx.csv'), writematrix(test_data,'Datasets\xx.csv') to store the training, validation and test datasets with appropriate filenames.

3. Configure Model Parameters:
   - Open appropriate Model file based on requirements:
     - For energy normalization with 1 hidden layer: `Model.m`
     - For energy normalization with 2 hidden layers: `Model_encoder2.m`
     - For power normalization with 1 hidden layer: `Model_power_constraint.m`
     - For power normalization with 2 hidden layers: `Model_power_constraint_encoder2.m`
   - Set parameters:
     - `k` (information bits)
     - `c` (control bits)
     - `EbNo` (Training Eb/No value in dB)
     - `KFactor` (Rician factor in dB)
   - Update file paths for test data and results:
     - Edit line test_data = readmatrix('datasets\xx.csv') to read from appropriate test data file
     - Edit line save('Results/xx.mat','BLER') to save the BLER values of trained model with appropriate filename
     - Edit line save(Model/xx.mat','BLER') to save the model parameters of trained model with appropriate filename
  
4. Run the Model file to train and save the model

5. Tune Hyperparameters:
   - Open corresponding TrainNetwork file:
     - For energy normalization with 1 hidden layer: `TrainNetwork.m`
     - For energy normalization with 2 hidden layers: `TrainNetwork_encoder2.m`
     - For power normalization with 1 hidden layer: `TrainNetwork_power_constraint.m`
     - For power normalization with 2 hidden layers: `TrainNetwork_power_constraint_encoder2.m`
   - Set `trainParams.MiniBatchSize`
   - Update training and validation dataset paths
   - Adjust number of nodes in fully connected layers


## 📊 Results & Evaluation
The Results directory contains all experimental outputs, organized into three main subdirectories:
1. **HyperparameterTuning**
   - BLER comparison plots for different hyperparameter combinations
   - Organized by test case and model type
   - Used to determine optimal model parameters for each test case and model type
2. **FrameworksComparison**
   - Comparative analysis between best models fordifferent frameworks (Simple AE, AE with Antenna Signature, Control bit encoded AE) for Open Loop AE and Closed Loop AE architectures
   - Performance benchmarks against baseline methods
   - Evaluates performance of best models across different test scenarios

3. **Constellation**
   - Visualization of signal constellations learned by the model
   - Helps in understanding the encoder's learned representation

## 📄 Documentation
For a detailed explanation of the autoencoder architectures and performance evaluation, refer to:
- [**Published Paper (IEEE Internet of Things Journal)**](https://doi.org/10.1109/JIOT.2024.3390443)

## 📬 Contact
For any inquiries, feel free to reach out:
- **GitHub:** [SelinaShrestha](https://github.com/SelinaShrestha)
- **LinkedIn:** [selinashrestha](https://www.linkedin.com/in/selinashrestha/)
- **Email:** shresth4@uci.edu | selina.shrestha@gmail.com
