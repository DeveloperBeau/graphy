<script>
  export let rows = [];

  function buildStamp(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="page-footer">
  <p>{buildStamp(rows)}</p>
</div>

<style>
  .page-footer {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
