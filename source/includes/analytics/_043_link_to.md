### Request key: `link-to` job details page

> An example message from iframe to parent window to link to job details page -

```html
<html>
<head>
  <script src="analytics-endpoint.js"></script>
  <script>
  AnalyticsEndpoint.onInit(function(initialData, transport) {
    ...
    transport.request("link-to", {
      link_to: "job_details_page",
      pipeline_name: "my_pipeline",
      pipeline_counter: 10,
      stage_name: "my_stage",
      stage_counter: 1,
      job_name: "job1"
    })
    .done(function(data) {
      console.log("Done! Navigated to job details page!");
    })
    .fail(function(errors) {
      console.log("Something failed: " + errors);
    });
  });

  AnalyticsEndpoint.ensure("v1");
  </script>
</head>
<body>
  ...
</body>
</html>
}
```

> This will be the equivalent of opening a new tab with the URL: `http://ci.example.com/go/tab/build/detail/my_pipeline/10/my_stage/1/job1`.

Any links opened directly from the plugin's front-end will open inside the iframe. For security reasons, the iframe cannot affect the
navigation of the parent GoCD window directly. Instead, the iframe can send a message with the key `link-to` to the
parent window to link to one of a specific set of GoCD pages.

The version `v1` of the message supports linking to the job details page. Upon receiving this message with correct parameters the parent
window will open the linked page in a new tab.

To link to the job details page, the parameter object should contain these keys:

| Key                | Description                             |
|--------------------|-----------------------------------------|
| `link_to`          | The value should be `job_details_page`. |
| `pipeline_name`    | The name of the pipeline the job is in. |
| `pipeline_counter` | The counter of the pipeline.            |
| `stage_name`       | The stage name the job is in.           |
| `stage_counter`    | The stage counter.                      |
| `job_name`         | The name of the job.                    |


### Request key: `link-to` VSM page

> An example message from iframe to parent window to link to VSM page:

```html
<html>
<head>
  <script src="analytics-endpoint.js"></script>
  <script>
  AnalyticsEndpoint.onInit(function(initialData, transport) {
    ...
    transport.request("link-to", {
      link_to: "vsm_page",
      pipeline_name: "my_pipeline",
      pipeline_counter: 10
    })
    .done(function(data) {
      console.log("Done! Navigated to VSM page!");
    })
    .fail(function(errors) {
      console.log("Something failed: " + errors);
    });
  });

  AnalyticsEndpoint.ensure("v1");
  </script>
</head>
<body>
  ...
</body>
</html>
}
```

> This will be the equivalent of opening a new tab with the URL: `http://ci.example.com/go/pipelines/value_stream_map/my_pipeline/10`.

Any links opened directly from the plugin's front-end will open inside the iframe. For security reasons, the iframe cannot affect the
navigation of the parent GoCD window directly. Instead, the iframe can send a message with the key `link-to` to the
parent window to link to one of a specific set of GoCD pages.

The version `v1` of the message supports linking to the VSM. Upon receiving this message
with correct parameters the parent window will open the linked page in a new tab.

To link to the VSM page, the parameter object should contain these keys:

| Key                | Description                          |
|--------------------|--------------------------------------|
| `link_to`          | The value should be `vsm_page`.      |
| `pipeline_name`    | The name of the pipeline to link to. |
| `pipeline_counter` | The counter of the pipeline.         |
