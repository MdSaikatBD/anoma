defmodule Anoma.ShieldedResource.ComplianceOutput do
  @moduledoc """
  I represent a resource's output.
  """

  use TypedStruct

  typedstruct enforce: true do
    # Nullifier
    field(:nullifier, binary())
    # Output output commitment
    field(:output_cm, binary())
    # Resource commitment Merkle tree root
    field(:root, binary())
    # Resource delta
    field(:delta_x, binary())
    field(:delta_y, binary())
    # Input Resource logic
    field(:input_logic, binary())
    # Output Resource logic
    field(:output_logic, binary())
  end

  @spec from_public_input(binary()) ::
          Anoma.ShieldedResource.ComplianceOutput.t()
  def from_public_input(public_input) do
    ## call cairo api to get output bytes
    [nullifier, output_cm, root, delta_x, delta_y, input_logic, output_logic] =
      public_input |> :binary.bin_to_list() |> Cairo.get_output()

    %Anoma.ShieldedResource.ComplianceOutput{
      nullifier: nullifier |> :binary.list_to_bin(),
      output_cm: output_cm |> :binary.list_to_bin(),
      root: root |> :binary.list_to_bin(),
      delta_x: delta_x |> :binary.list_to_bin(),
      delta_y: delta_y |> :binary.list_to_bin(),
      input_logic: input_logic |> :binary.list_to_bin(),
      output_logic: output_logic |> :binary.list_to_bin()
    }
  end
end