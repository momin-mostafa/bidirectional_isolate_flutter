## Bidirectional Isolate Flutter

This project delves into exploring and benchmarking various techniques for executing computations in separate threads within Flutter applications, prioritizing a smooth and responsive user interface (UI). By efficiently parallelizing tasks, we strive to achieve concurrency without compromising the seamless user experience that Flutter excels at.

This R&D (Spike) Projects shows you to create and manage bidirectional communication between isolates. Isolates are separate threads of execution that can run independently of each other. This can be useful for tasks that are computationally expensive or that require a lot of memory.

There are three main files:

- main.dart: This is the main file of the application. It contains the code that creates the isolates and starts the communication between them.
- compute_test.dart: This file contains the code that performs the heavy computation. It is executed in a separate isolate.
- presistant_thread.dart: This shows how to exit isolate on specific message.
- data_sharing.dart: This file contains the code that demonstrates how to share data between isolates.


**Motivation:**

- Maintaining a fluid and responsive UI is paramount in user-centric app design.
- Flutter leverages a single-threaded UI model, which can become a bottleneck for CPU-intensive operations.
- Isolates in Dart provide a mechanism for offloading computations to other threads, enhancing app performance.

**Goals:**

- Evaluate different isolate communication approaches, including bidirectional message passing and unidirectional streams.
- Measure the performance impact of each approach on key metrics like frame rate and latency.
- Gain practical insights and best practices for using isolates effectively in Flutter.

**Approach:**

1. **Implementation:** Develop implementations for various isolate communication methods, ensuring clarity and maintainability.
2. **Benchmarking:** Design comprehensive benchmarks that exercise different use cases and thread-intensive tasks.
3. **Analysis:** Conduct rigorous analysis of performance data, identifying strengths and weaknesses of each approach.
4. **Documentation:** Share findings and recommendations in a well-structured README, enabling others to benefit from your work.

**Expected Outcomes:**

- Establish a solid understanding of bidirectional and unidirectional communication in Flutter isolates.
- Gain quantitative data on the performance implications of different communication strategies.
- Provide valuable guidance for developers on using isolates effectively in their Flutter apps.

**Getting Started:**

1. Clone the repository: `git clone https://github.com/momin-mostafa/bidirectional_isolate_flutter.git`
2. Run the app: `flutter run`
3. Follow the instructions in the app to run benchmarks and explore different isolate communication methods.

**Contribution:**

We welcome contributions to this project in the form of bug reports, feature requests, and improvements to the code or documentation. Please use the issue tracker or create pull requests on GitHub.
