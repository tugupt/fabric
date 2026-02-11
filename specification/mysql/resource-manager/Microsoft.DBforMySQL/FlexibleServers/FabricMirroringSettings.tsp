import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@versioned(Versions)
namespace Microsoft.DBforMySQL;

/**
 * State of Fabric Mirroring.
 * Extensible string-based union per Azure guidelines.
 */
@added(Versions.v2025_12_01_preview)
union FabricMirroringState {
  /** Fabric Mirroring is enabled. */
  Enabled: "Enabled",

  /** Fabric Mirroring is disabled. */
  Disabled: "Disabled",

  /** Future/unknown values. */
  string,
}

/**
 * Provisioning state of Fabric Mirroring.
 * Extensible string-based union per Azure guidelines.
 */
@added(Versions.v2025_12_01_preview)
union FabricMirroringProvisioningState {
  /** Provisioning has succeeded. */
  Succeeded: "Succeeded",

  /** Provisioning is in progress. */
  Updating: "Updating",

  /** Provisioning was canceled. */
  Canceled: "Canceled",

  /** Provisioning has failed. */
  Failed: "Failed",

  /** Future/unknown values. */
  string,
}

/**
 * Properties of the Fabric Mirroring settings resource.
 */
@added(Versions.v2025_12_01_preview)
model FabricMirroringSettingsProperties {
  /** State of Fabric Mirroring (Enabled or Disabled). */
  state?: FabricMirroringState;

  /** Resource ID of the user-assigned managed identity used for Fabric Mirroring. */
  identityResourceId?: armResourceIdentifier;

  /** Provisioning state of Fabric Mirroring. */
  @visibility(Lifecycle.Read)
  provisioningState?: FabricMirroringProvisioningState;
}

/**
 * Fabric Mirroring settings proxy resource.
 */
@parentResource(Server)
model FabricMirroringSettings is ProxyResource<FabricMirroringSettingsProperties> {
  ...ResourceNameParameter<FabricMirroringSettings>;
}

@armResourceOperations
interface FabricMirroringSettingsOperations {
  @doc("Get Fabric Mirroring settings.")
  @added(Versions.v2025_12_01_preview)
  get is ArmResourceRead<FabricMirroringSettings>;

  @doc("Create or update Fabric Mirroring settings.")
  @added(Versions.v2025_12_01_preview)	
  createOrUpdate is ArmResourceCreateOrUpdateAsync<FabricMirroringSettings>;

  @doc("List Fabric Mirroring settings by server.")
  @added(Versions.v2025_12_01_preview)
  listByServer is ArmResourceListByParent<FabricMirroringSettings>;
}