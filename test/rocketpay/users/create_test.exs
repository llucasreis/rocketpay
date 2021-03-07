defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.{User, Repo}
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Lucas",
        password: "123456",
        nickname: "lprs",
        email: "lprs@gmail.com",
        age: 23
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Lucas", age: 23, id: ^user_id} = user
    end

    test "when there are invalid params, returns an user" do
      params = %{
        name: "Lucas",
        nickname: "lprs",
        email: "lprs@gmail.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
