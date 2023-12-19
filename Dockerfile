# Use a base image with Bash
FROM ubuntu:latest

# Set the working directory inside the container
WORKDIR /OS1-Project

# Copy your project files into the container
COPY . /OS1-Project

# (Optional) Install any dependencies or run setup commands
# Update the package index
RUN apt-get update && apt-get install sudo
#RUN apt-get update && sudo apt-get install vim

# Install sudo




# Example: RUN apt-get update && apt-get install -y <package>

# Specify the command to run when the container starts
CMD ["bash"]

