from langchain.chains import LLMChain
from langchain_community.llms.cloudflare_workersai import CloudflareWorkersAI
from langchain_core.prompts import PromptTemplate

import os
from dotenv import load_dotenv
from langchain_experimental.agents import create_pandas_dataframe_agent
import pandas as pd
import requests
import matplotlib as plt
import seaborn as sns

import streamlit as st

load_dotenv()

def get_events():
    base_url= os.getenv("EVENTS_REPORT_REQUEST_URL")
    headers = {
        'Content-Type': 'application/json'
    }
    try:
        response = requests.get(base_url, headers=headers)
        if response.status_code == 200:
            result = response.json()
            if "errors" in result:
                return "recordNotFound"
            return result
        else:
            return f"Failed to retrieve data. Status code: {response.status_code}"
    except Exception as e:
        return str(e)

events_response = pd.DataFrame(get_events())

# Display the dataframe in the Streamlit app
st.title("Events Report Analysis")
st.write("Here is the current data on events:")
st.dataframe(events_response)

my_account_id = os.getenv("CLOUDFLARE_ACCOUNT_ID")
my_api_token = os.getenv("CLOUDFLARE_API_TOKEN")
llm = CloudflareWorkersAI(account_id=my_account_id, api_token=my_api_token)

agent = create_pandas_dataframe_agent(llm, events_response, verbose=True, allow_dangerous_code=True, return_intermediate_steps=True, handle_parsing_errors=True)

# Agent interaction
st.write("Ask a question about the events data:")
user_query = st.text_input("Enter your question")

def get_response(user_query):
    try:
        result = agent.invoke({"input": user_query})
        # Check if the result contains both an error and an answer
        if isinstance(result, dict) and 'output' in result:
            response = result['output'] # Only display the final answer
        else:
            response = result  # Display the entire result if it's just the final answer

    except ValueError as e:
        err = str(e)
        answerIndex = err.find('Final Answer: ')
        response = err[answerIndex:]
    return response

if user_query:
    # Run the agent with user input and display the result
    with st.spinner("Running query..."):
        st.write(get_response(user_query))
        