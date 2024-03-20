import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashSet;
import java.util.Objects;
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
        return Objects.equals(address, record.address) &&
                Objects.equals(email, record.email) &&
                Objects.equals(phone, record.phone) &&
                Objects.equals(tin, record.tin);
    }

    @Override
    public int hashCode() {
        return Objects.hash(address, email, phone, tin);
    }
}

public class CSVProcessor {
    public static void main(String[] args) {
        String inputFile = "input.csv";
        String outputFile = "output.csv";

        Set<Record> uniqueRecords = new HashSet<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 4) { // Assuming there are at least 4 columns
                    Record record = new Record(parts[0], parts[1], parts[2], parts[3]);
                    uniqueRecords.add(record);
                }
            }

            // Write unique records to the output file
            for (Record record : uniqueRecords) {
                writer.write(record.address + "," + record.email + "," + record.phone + "," + record.address); // Concatenate address with itself for uniqueness
                writer.newLine();
            }

            System.out.println("Unique records written to " + outputFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
