# lab-config
GitOps for my personal home/cloud lab.

## Layout

```
lab-config/
├── <project>/            # The main lab project
│   ├── <infra?>/         # Optional: infrastructure definitions
│   └── <kubernetes?>/    # Optional: Kubernetes configuration
├── LICENSE               # License information
└── README.md             # Main documentation
```

## Projects

### infra-state

The storage for various infrastructue tooling state.

### home-cluster

My home Kubernetes cluster running on Talos managed by Omni.
