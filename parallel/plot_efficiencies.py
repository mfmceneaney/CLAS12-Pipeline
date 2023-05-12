import pandas as pd
import matplotlib.pyplot as plt

# columns = ["i", 
#             "completed", 
#             "timeout", 
#             "fail", 
#             "node_fail", 
#             "cpu_used", 
#             "cpu_efficiency", 
#             "mem_used", 
#             "mem_efficiency"
#         ]
verbose = True
infile = "/Users/mfm45/drop/efficiencies.txt"
sep    = " "
header = None
df = pd.read_csv(infile, sep=sep) #NOTE: Don't set header, otherwise dtypes and column names will not be accessible.

# Convert to standard timedelta notation #NOTE: Needed to be able to use timedelta below
for i in range(len(df)):
    df["cpu_used"][i] = df["cpu_used"][i].replace("-"," days ")

# Get subsets
df_completed = df.loc[df["completed"]==1]
df_not_completed = df.loc[df["completed"]==0]
df_timeout = df.loc[df["timeout"]==1]
df_fail = df.loc[df["fail"]==1]
df_node_fail = df.loc[df["node_fail"]==1]

# Plot everything versus job index
print("DEBUGGING:  df.columns = ",df.columns)
figsize=(16,10)
figs = [None for i in range(len(df.columns))]
for idx, col in enumerate(df.columns):
    print("DEBUGGING: col = ",col)
    if col=="i": continue
    
    x_completed = df_completed["i"]
    y_completed = df_completed[col]
    x_failed = df_not_completed["i"]
    y_failed = df_not_completed[col]
    if col=="cpu_used":
        y_completed = pd.to_timedelta(y_completed)
        y_failed    = pd.to_timedelta(y_failed)
    figs[idx] = plt.figure(figsize=figsize)
    plt.scatter(x_completed,y_completed,marker='o',color='b', linestyle='None',label="Completed")
    plt.scatter(x_failed,y_failed,marker='o',color='r', linestyle='None',label="Failed")
    if '_efficiency' in col: plt.ylim(0.0,100.0) #NOTE: NEEDS TO BE RIGHT AFTER PLOTTING, NOT BEFORE.  ALSO, EFFECIENCIES ARE REPORTED IN PERCENTAGES.
    plt.legend(loc="best")
    plt.xlabel("i")
    plt.ylabel(col)

# # Plot completed versus job index
# print("DEBUGGING:  df.columns = ",df_completed.columns)
# figsize=(16,10)
# figs = [None for i in range(len(df_completed.columns))]
# for idx, col in enumerate(df_completed.columns):
#     print("DEBUGGING: col = ",col)
    
#     x = df_completed["i"]
#     y = df_completed[col]
#     if col=="cpu_used": y = pd.to_timedelta(y)
#     if 'efficiency' in col: plt.ylim(0.0,100.0) #NOTE: EFFECIENCIES ARE REPORTED IN PERCENTAGES.
#     figs[idx] = plt.figure(figsize=figsize)
#     plt.plot(x,y)
#     plt.xlabel("i")
#     plt.ylabel(col)

# # Plot completed versus job index
# print("DEBUGGING:  df.columns = ",df_not_completed.columns)
# figsize=(16,10)
# figs = [None for i in range(len(df_not_completed.columns))]
# for idx, col in enumerate(df_not_completed.columns):
#     print("DEBUGGING: col = ",col)
    
#     x = df_not_completed["i"]
#     y = df_not_completed[col]
#     if col=="cpu_used": y = pd.to_timedelta(y)
#     if 'efficiency' in col: plt.ylim(0.0,100.0) #NOTE: EFFECIENCIES ARE REPORTED IN PERCENTAGES.
#     figs[idx] = plt.figure(figsize=figsize)
#     plt.plot(x,y)
#     plt.xlabel("i")
#     plt.ylabel(col)

# # Plot timeout versus job index
# print("DEBUGGING:  df.columns = ",df_timeout.columns)
# figsize=(16,10)
# figs = [None for i in range(len(df_timeout.columns))]
# for idx, col in enumerate(df_timeout.columns):
#     print("DEBUGGING: col = ",col)
    
#     x = df_timeout["i"]
#     y = df_timeout[col]
#     if col=="cpu_used": y = pd.to_timedelta(y)
#     if 'efficiency' in col: plt.ylim(0.0,100.0) #NOTE: EFFECIENCIES ARE REPORTED IN PERCENTAGES.
#     figs[idx] = plt.figure(figsize=figsize)
#     plt.plot(x,y)
#     plt.xlabel("i")
#     plt.ylabel(col)

# Show plots if requested
if verbose: plt.show()
