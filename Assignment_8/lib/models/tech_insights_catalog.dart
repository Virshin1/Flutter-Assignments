/// Curated technical articles mapped to JSONPlaceholder posts to provide
/// meaningful, readable engineering content instead of raw Latin placeholder text.
class TechInsightsCatalog {
  static const Set<String> _latinTokens = {
    'sunt', 'aut', 'facere', 'repellat', 'provident', 'qui', 'est', 'esse',
    'ea', 'molestias', 'eum', 'occaecati', 'rerum', 'dolor', 'dolorem',
    'voluptate', 'voluptatem', 'nihil', 'reprehenderit', 'nesciunt',
    'architecto', 'optio', 'ullam', 'suscipit', 'iusto', 'adipisci',
    'fugiat', 'tempore', 'quas', 'soluta', 'blanditiis', 'lorem',
    'ipsum', 'amet', 'consectetur', 'elit', 'tempor', 'iure', 'recusandae',
    'expedita', 'vitae', 'libero', 'velit', 'possimus', 'magnam', 'facilis',
    'sequi', 'beatae', 'dolores', 'tenetur', 'commodi', 'deleniti', 'atque'
  };

  static bool isLatinText(String? text) {
    if (text == null || text.trim().isEmpty) return false;
    final words = text.toLowerCase().split(RegExp(r'[^a-z]+'));
    int count = 0;
    for (final w in words) {
      if (_latinTokens.contains(w)) {
        count++;
        if (count >= 2) return true;
      }
    }
    return count >= 1 && words.length <= 5;
  }

  static final List<Map<String, String>> _articles = [
    {
      'title': 'Architecting Multi-Region Resiliency on Kubernetes & AWS',
      'body':
          'Building high-availability infrastructure across cloud availability zones requires distributed state management, zero-downtime rolling deployments, and automated DNS failovers. Here is how modern cloud teams design for 99.999% uptime with service meshes and active-active replicas.',
    },
    {
      'title': 'Zero-Trust Security: Implementing Inter-Service mTLS & SPIFFE',
      'body':
          'Traditional perimeter security is obsolete in hybrid cloud environments. By implementing mutual TLS with automated SPIFFE/SPIRE certificate rotation, every inter-service call is cryptographically validated and authorized based on real-time identity policies.',
    },
    {
      'title': 'Accelerating CI/CD Pipelines: Reducing Build Times by 65%',
      'body':
          'Monorepo development presents unique build cache challenges. By introducing remote distributed build caching with Bazel and containerized runner pools, our team reduced median pull request validation times from 28 minutes to under 9 minutes.',
    },
    {
      'title': 'Optimizing Vector Embeddings for Production RAG Pipelines',
      'body':
          'Retrieval-Augmented Generation (RAG) often suffers from recall degradation when chunk sizes are misaligned with embedding dimensionality. Hierarchical semantic chunking combined with hybrid BM25 and vector reranking yields 40% higher precision.',
    },
    {
      'title': 'Linux Kernel Observability: Deep Dive into Modern eBPF',
      'body':
          'Extended Berkeley Packet Filter (eBPF) transforms kernel instrumentation by allowing sandboxed bytecode to run safely inside the Linux kernel. This facilitates non-invasive network monitoring, real-time security auditing, and nanosecond-precision profiling.',
    },
    {
      'title': 'High-Performance State Management in Flutter 3.27',
      'body':
          'Selecting the right state management architecture depends heavily on widget tree depth and rebuild frequencies. Unidirectional data flows paired with immutable models prevent redundant builds and memory leaks in production apps.',
    },
    {
      'title': 'Database Sharding Patterns: Scaling PostgreSQL Past 100k TPS',
      'body':
          'When vertical database scaling reaches hardware thresholds, horizontal partitioning becomes imperative. Utilizing Citus extensions alongside consistent hashing enables seamless distributed table distribution while preserving ACID guarantees.',
    },
    {
      'title': 'Automated Canary Deployments with Prometheus & Argo Rollouts',
      'body':
          'Progressive delivery minimizes blast radius during major releases. By analyzing real-time error rates and latency histograms against baseline metrics, failed deployments are rolled back within seconds without human intervention.',
    },
    {
      'title': 'Zero-JS Islands and Edge Rendering for Sub-Second TTFB',
      'body':
          'Modern web applications often suffer from JavaScript bloat. Adopting island architectures and server-side streaming at edge CDNs drastically reduces Time to First Byte (TTFB) and Total Blocking Time across mobile devices.',
    },
    {
      'title': 'Implementing Passkeys and WebAuthn for Passwordless Auth',
      'body':
          'FIDO2 passkeys replace vulnerable passwords with cryptographic key pairs stored in hardware security enclaves. Here is how enterprise applications transition users to seamless biometric authentication.',
    },
    {
      'title': 'Event-Driven Systems: Kafka vs RabbitMQ Architectural Tradeoffs',
      'body':
          'Choosing between log-centric streaming architectures like Apache Kafka and traditional message brokers like RabbitMQ hinges on message retention and consumer semantics. We evaluate throughput, backpressure, and ordering guarantees.',
    },
    {
      'title': 'Edge Computing: Deploying Quantized LLMs on Mobile Devices',
      'body':
          'Running generative models locally on mobile hardware eliminates cloud latency and protects user privacy. Leveraging 4-bit AWQ quantization and Apple Neural Engine acceleration allows 3B parameter models to run smoothly at 24 tokens per second.',
    },
    {
      'title': 'Designing Resilient Microservices with Distributed Tracing',
      'body':
          'Modern distributed systems require comprehensive telemetry to isolate latency bottlenecks. By deploying OpenTelemetry collectors alongside service mesh sidecars, engineering teams can trace cross-boundary RPC requests in real time.',
    },
    {
      'title': 'Offline-First Mobile Architecture: SharedPreferences & SQLite',
      'body':
          'Network unreliability should never degrade the core user experience. By caching raw REST API responses in local storage and pairing background synchronization with optimistic UI updates, applications remain fast and reliable.',
    },
    {
      'title': 'Memory Leak Diagnostics in Long-Running Dart & Flutter Apps',
      'body':
          'Retained objects and unclosed stream controllers can silently degrade application performance over extended sessions. We explore the Flutter DevTools Memory Profiler to track retain paths and heap snapshot diffs.',
    },
    {
      'title': 'GraphQL Federation: Unifying Microservice Graphs at Scale',
      'body':
          'Monolithic GraphQL schemas become bottlenecks as teams scale. Apollo Federation enables independent squads to own their subgraphs while presenting a single, unified GraphQL gateway to client applications.',
    },
    {
      'title': 'Securing Mobile API Gateways Against Reverse Engineering',
      'body':
          'Hardcoded API keys and client credentials can be easily extracted from decompiled APKs or IPAs. Implementing dynamic token attestation with SafetyNet/App Check and short-lived JWTs ensures only genuine clients access backend endpoints.',
    },
    {
      'title': 'Container Hardening: Building Minimal Distroless Docker Images',
      'body':
          'Standard base images contain package managers, shells, and utilities that expand the attack surface. Migrating production containers to Google Distroless or Chainguard images removes unnecessary binaries and shrinks vulnerabilities.',
    },
    {
      'title': 'Scaling Redis Caches: Cluster Sharding & Eviction Policies',
      'body':
          'In-memory key-value caches often face thundering herd issues and uneven key distribution. We analyze consistent hashing algorithms, key expiration jitter, and LRU versus LFU eviction trade-offs under high concurrency.',
    },
    {
      'title': 'Next-Generation WebSockets: Multiplexing with WebTransport & QUIC',
      'body':
          'Traditional WebSockets run over TCP and are prone to head-of-line blocking on lossy connections. WebTransport leverages HTTP/3 and QUIC datagrams to deliver ultra-low latency real-time streaming for collaboration tools.',
    },
  ];

  static String getCuratedTitle(int id) {
    final index = (id - 1).abs() % _articles.length;
    return _articles[index]['title']!;
  }

  static String getCuratedBody(int id) {
    final index = (id - 1).abs() % _articles.length;
    return _articles[index]['body']!;
  }
}
