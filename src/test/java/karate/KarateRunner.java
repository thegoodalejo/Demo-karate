package karate;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import utils.CucumberReport;

import static org.junit.jupiter.api.Assertions.assertEquals;

class KarateRunner {

    public KarateRunner() {
        super();
    }

    @Test
    void testParallel() {
        Results results = Runner
                .path("classpath:karate")
                .outputCucumberJson(true)
                .parallel(3);

        CucumberReport.createCucumberReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
