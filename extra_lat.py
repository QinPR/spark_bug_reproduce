import re

def extract_max_nanoseconds(log_file_path):
    max_nanoseconds = 0
    pattern = r"Time taken for serializedMapStatus: (\d+) nanoseconds"

    with open(log_file_path, 'r') as file:
        for line in file:
            match = re.search(pattern, line)
            if match:
                nanoseconds = int(match.group(1))
                if nanoseconds > max_nanoseconds:
                    max_nanoseconds = nanoseconds
    return max_nanoseconds


def calculate_average_nanoseconds(log_file_path):
    total_nanoseconds = 0
    count = 0
    pattern = r"Time taken for serializedMapStatus: (\d+) nanoseconds"

    with open(log_file_path, 'r') as file:
        for line in file:
            match = re.search(pattern, line)
            if match:
                nanoseconds = int(match.group(1))
                total_nanoseconds += nanoseconds
                count += 1

    average_nanoseconds = total_nanoseconds / count if count > 0 else 0

    return average_nanoseconds

log_file_path = '/mnt/spark-exp/output_fix_ver.txt'
output_file_path = '/mnt/spark-exp/avg_lat_fix_ver.txt'
avg_time = calculate_average_nanoseconds(log_file_path)

with open(output_file_path, 'w') as output_file:
    output_file.write(f"{avg_time / 1000000}") # convert to ms

print(f"The avg time taken for serializedMapStatus is: {avg_time} nanoseconds")