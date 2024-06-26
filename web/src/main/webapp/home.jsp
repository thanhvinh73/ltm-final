<%@page import="model.dto.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>DHV - Home</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script>
      var preview_base_img = function (event) {
        var output = document.getElementById("base_img_preview");
        output.src = URL.createObjectURL(event.target.files[0]);
        output.onload = function () {
          URL.revokeObjectURL(output.src);
        };
      };

      var preview_compare_img = function (event) {
        var output = document.getElementById("compare_img_preview");
        output.src = URL.createObjectURL(event.target.files[0]);
        output.onload = function () {
          URL.revokeObjectURL(output.src);
        };
      };

      var onLoad = function () {
        const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);
        const message = urlParams.get("error-message");
        if (message) {
          alert(message);
        }
      };
    </script>
  </head>

  <body onload="onLoad()">
    <div class="min-h-screen w-full flex flex-col bg-gray-300 text-base">
      <div
        class="mx-auto w-full max-w-7xl h-full p-10 bg-white flex flex-row rounded-md my-4"
      >
        <div
          class="flex-1 h-full gap-1 flex flex-col item-start border-r mr-6 pr-6"
        >
          <form
            action="/web/request"
            method="POST"
            enctype="multipart/form-data"
            class="w-full flex flex-col justify-between item-center gap-4"
          >
            <h3 class="text-2xl font-semibold">Upload images</h3>

            <div class="w-full">
              <div
                class="flex flex-col rounded-lg shadow-lg p-8 gap-4 item-start border border-gray-200"
              >
                <div class="flex flex-row item-center justify-between gap-4">
                  <label for="base_img" class="font-semibold capitalize"
                    >Base Image</label
                  >

                  <input
                    type="file"
                    id="base_img"
                    name="base_img"
                    accept="image/*"
                    required
                    onchange="preview_base_img(event)"
                  />
                </div>

                <div class="flex flex-row item-center justify-between gap-4">
                  <label for="compare_img" class="font-semibold capitalize"
                    >Compare Image</label
                  >

                  <input
                    type="file"
                    id="compare_img"
                    name="compare_img"
                    accept="image/*"
                    required
                    onchange="preview_compare_img(event)"
                  />
                </div>
              </div>
            </div>

            <div class="flex item-center justify-center">
              <button
                type="submit"
                class="bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
              >
                Submit
              </button>
            </div>
          </form>

          <div id="preview" class="flex flex-col gap-4">
            <h3 class="text-2xl font-semibold">Preview</h3>

            <div class="w-full flex flex-col gap-4 item-start">
              <div class="flex flex-col item-center justify-between gap-3">
                <div class="flex-1 flex item-center justify-start">
                  <img
                    id="base_img_preview"
                    src="./static/no-image.png"
                    alt="Base image"
                    class="w-2/3 h-auto rounded-md"
                  />
                </div>

                <div class="w-8 h-auto m-auto rotate-90">
                  <img
                    src="./static/compare.png"
                    alt="Compare icon"
                    class="object-cover font-weight-bold"
                  />
                </div>

                <div class="flex-1 flex item-center justify-end">
                  <img
                    id="compare_img_preview"
                    src="./static/no-image.png"
                    alt="Compare image"
                    class="w-2/3 h-auto rounded-md"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="w-2/5 flex flex-col gap-4 item-start">
          <div class="flex flex-row">
            <h3 class="text-2xl font-semibold">History</h3>
            <a
              href="/web/home?logout=true"
              class="ml-auto bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
              >Log out</a
            >
          </div>

          <!-- Loop -->
          <%
            List<RequestDto> requestDtoList = (List<RequestDto>)request.getSession().getAttribute("requestDtoList");
            if (requestDtoList != null && requestDtoList.size () >0) {
              for (RequestDto requestDto : requestDtoList) {
                requestDto.setFirstImage("http://127.0.0.1:8081/" + requestDto.getFirstImage());
                requestDto.setSecondImage("http://127.0.0.1:8081/" + requestDto.getSecondImage());
          %>
            <div class="p-2 flex flex-col border-b">
              <div class="flex flex-row gap-2 item-center justify-between">
                <div>
                  <img src=<%= requestDto.getFirstImage()%> class="h-32 w-auto" />
                </div>

                <div class="flex item-center justify-center">
                  <img src="./static/compare.png" class="h-8 w-auto m-auto" />
                </div>

                <div>
                  <img src=<%= requestDto.getSecondImage()%> class="h-32 w-auto" />
                </div>
              </div>

              <div class="flex flex-row gap-2 item-center justify-between">
                <% if (requestDto.isResultNull()) { %>
                  <p>Result: Processing...</p>
                <% } else {%>
                  <p>Result: <%= requestDto.isResult()%></p>
                <% } %>

                <% if (requestDto.isDistanceNull()) { %>
                  <p>Distance: Processing...</p>
                <% } else {%>
                  <p>Distance: <%= requestDto.getDistanceValue()%></p>
                <% } %>
              </div>
            </div>
          <%
              }
            } else {
          %>
              <div class="">No history </div>
          <% } %>
          <!--  End of loop -->
        </div>
      </div>
    </div>
  </body>
</html>
