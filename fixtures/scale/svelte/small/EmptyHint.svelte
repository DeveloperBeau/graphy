<script>
  const samples = ['build.log', 'server.log'];

  function hintText() {
    return 'Try one of: ' + samples.join(', ');
  }
</script>

<p class="empty-hint">Nothing to preview yet. {hintText()}</p>

<style>
  .empty-hint {
    opacity: 0.6;
    text-align: center;
    margin-top: 3rem;
  }
</style>
