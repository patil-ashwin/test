
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

class Record {
    private String address;
    private String email;
    private String phone;
    private String tin;

    public Record(String address, String email, String phone, String tin) {
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.tin = tin;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Record record = (Record) o;
        return address.equals(record.address) &&
                email.equals(record.email) &&
                phone.equals(record.phone) &&
                tin.equals(record.tin);
    }

    @Override
    public int hashCode() {
        return Objects.hash(address, email, phone, tin);
    }
}

public class CSVProcessor {
    public static void main(String[] args) {
        String inputFile = "input.csv";
        int maxRecordsPerFile = 1000;

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile))) {
            String line;
            int fileCount = 1;
            Set<Record> uniqueRecords = new HashSet<>();

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4) { // Assuming there are at least 4 columns
                    Record record = new Record(parts[0], parts[1], parts[2], parts[3]);
                    uniqueRecords.add(record);

                    if (uniqueRecords.size() >= maxRecordsPerFile) {
                        writeToFile(uniqueRecords, "output_" + fileCount + ".csv");
                        uniqueRecords.clear();
                        fileCount++;
                    }
                }
            }

            // Write remaining unique records to the last file
            if (!uniqueRecords.isEmpty()) {
                writeToFile(uniqueRecords, "output_" + fileCount + ".csv");
            }

            System.out.println("Unique records written to output files.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void writeToFile(Set<Record> records, String outputFile) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {
            for (Record record : records) {
                writer.write(record.address + "," + record.email + "," + record.phone + "," + record.address); // Concatenate address with itself for uniqueness
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
