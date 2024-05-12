import org.apache.spark.sql.SparkSession
import org.slf4j.LoggerFactory
import scala.concurrent.Future
import scala.concurrent.ExecutionContext.Implicits.global

object Bug29351_fix {
  val logger = LoggerFactory.getLogger(getClass.getName)

  def main(args: Array[String]): Unit = {
    // Initialize SparkSession
    val spark = SparkSession.builder
      .appName("Trigger Shuffle Status Example")
      .master("spark://127.0.1.1:7077")
      .getOrCreate()

    // Generate a larger dataset and increase key repetition
    val numItems = 100  // Increase number of items
    val num_taks = 100000

    val data = (1 to numItems).map(i => ((i % 100), s"value_$i"))  // Increase key repetition by decreasing the modulus
    val rdd = spark.sparkContext.parallelize(data, numSlices = num_taks)  // Decrease number of slices

    // Perform a more complex shuffle operation
    val groupedData = rdd.groupByKey(numPartitions = num_taks)  // Optionally control the number of partitions during shuffle

    // Action to trigger the shuffle process
    println(s"Count of grouped data: ${groupedData.count()}")

    // Stop SparkSession
    spark.stop()
  }
}
