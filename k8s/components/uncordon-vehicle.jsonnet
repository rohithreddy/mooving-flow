local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['uncordon-vehicle'];
local version = std.extVar('IMAGE_VERSION');

{
  apiVersion: 'operators.srfrnk.com/v1',
  kind: 'FlinkJob',
  metadata: {
    name: 'uncordon-vehicle',
    namespace: 'flows',
    labels: {
      app: 'uncordon-vehicle',
      version: version,
    },
  },
  spec: {
    version: version,
    streaming: {
      replicas: 1,
    },
    jobManagerUrl: 'flink-jobmanager.flink:8081',
    jarImage: 'gcr.io/' + params.GCP_PROJECT + '/flow:' + version,
    jarPath: '/jars/dav-flow-0.1.jar',
    mainClass: 'org.dav.vehicle_rider.UncordonFlow',
    props: params.props,
  },
}
