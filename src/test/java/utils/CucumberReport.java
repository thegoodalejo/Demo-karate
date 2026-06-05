package utils;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class CucumberReport {

    public static void createCucumberReport(String reportDir) {
        File reportOutputDirectory = new File(reportDir);

        List<String> jsonFiles = new ArrayList<>();
        File[] files = reportOutputDirectory.listFiles((dir, name) -> name.endsWith(".json"));
        if (files != null) {
            for (File file : files) {
                jsonFiles.add(file.getAbsolutePath());
            }
        }

        Configuration configuration = new Configuration(reportOutputDirectory, "mi-proyecto-karate");
        ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, configuration);
        reportBuilder.generateReports();
    }
}
